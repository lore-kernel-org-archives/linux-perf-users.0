Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77168C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 19:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjAET7j (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 14:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjAET7h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 14:59:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13BE17589
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 11:59:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so3078188pjq.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jan 2023 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G6MY7nruquscISG2PiN5KCqnGZMtc/2v+wrwlGfSPyg=;
        b=tM+6O86wCUABwOfRrnO10ks8jWIko+HiIU9L21smJibwScoqZGC6l9zhdG+9Q44WKD
         WQNSkucPngW4fkcR+C0rfo0p61eoEvJr3OC7i3RwVno5gXeWHWcPm6esol0/J4BHZtHM
         PqOSwfutM8YZsoqyKECRRBImJ805NqW1GsIz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6MY7nruquscISG2PiN5KCqnGZMtc/2v+wrwlGfSPyg=;
        b=siA2jeanL3ERvw/HByDoHFsWXIWcDTYR46rLuHK1g2HypkP5UVJvYigDG61v8MeSiP
         3Drq3WtFXaPHhLdyAa1cZKJMgothLjaMuzV22Gk+8KmdyUrtNyorRo8zCGMk96OkajUc
         t0g+wKG7cpTK015mFsEhvGEdb0MheWjE2cbmKuJ+1AspNDs62IXpfLdHBRAtewz2F1ei
         5Mi6h5oRkazP299qZ5lMiDdnRehCM09+Jn1r7Lx+735+pf0uvDH/rv7BOXloVQ4h06oJ
         /mwsq4TebS/ITkFUe/2YtQY0BK6uozCgz5an2KZvDM7ta1J+gzH2sfoejwCZwyi/jfua
         8gXA==
X-Gm-Message-State: AFqh2ko/89TURlZrqEK/UkeassiD/7OJQoNdCkXh2OxWtFxfyl6IVk41
        hdxM5Rpu2Xb6zc1bOmcAHyVdDQh1Fxfu1ozoeVHFPH4tHWjomCA=
X-Google-Smtp-Source: AMrXdXs+5alvXeD+V8cyRkDyEUifzZBODvRmhsHvz5VF8nMUcQR7V/ot79Apnn/60FnaE0jmJXBIEUPjzkZJuRGFCV8=
X-Received: by 2002:a17:90a:bd0e:b0:225:cd98:1651 with SMTP id
 y14-20020a17090abd0e00b00225cd981651mr3768100pjr.93.1672948776000; Thu, 05
 Jan 2023 11:59:36 -0800 (PST)
MIME-Version: 1.0
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 5 Jan 2023 11:59:24 -0800
Message-ID: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
Subject: Expected rdpmc behavior during context swtich and a RISC-V conundrum
To:     linux-perf-users@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Beeman Strong <beeman@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi All,
There was a recent uabi update[1] for RISC-V that allows the users to
read cycle and instruction count without any checks.
We tried to restrict that behavior to address security concerns
earlier but it resulted in breakage for some user space
applications[2].
Thus, previous behavior was restored where a user on RISC-V platforms
can directly read cycle or instruction count[3].

Comparison with other ISAs w.r.t user space access of counters:
ARM64
  -- Enabled/Disabled via (/proc/sys/kernel/perf_user_access)
  -- Only for task bound events configured via perf.

X86
 --- rdpmc instruction
 --- Enable/Disable via =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D
-- Before v4.0
 -- any process (even without active perf event) rdpmc
After v4.0
-- Default behavior changed to support only active events in a
process=E2=80=99s context.
-- Configured through perf similar to ARM64
-- Continue to maintain backward compatibility for unrestricted access
by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D

IMO, RISC-V should only enable user space access through perf similar
to ARM64 and x86 (post v4.0).
However, we do have to support the legacy behavior to avoid
application breakage.
As per my understanding a direct user space access can lead to the
following problems:

1) There is no context switch support, so counts from other contexts are ex=
posed
2) If a perf user is allocated one of these counters, the counter
value will be written

Looking at the x86 code as it continues to allow the above behavior,
rdpmc_always_available_key is enabled in the above case. However,
during the context switch (cr4_update_pce_mm)
only dirty counters are cleared. It only prevents leakage from perf
task to rdpmc task.

How does the context switch of counters work for users who enable
unrestricted access by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=
=9D ?
Otherwise, rdpmc users likely get noise from other applications. Is
that expected ?
This can be a security concern also where a rogue rdpmc user
application can monitor other critical applications to initiate side
channel attack.

Am I missing something? Please correct my understanding of the x86
implementation if it is wrong.

[1] https://lore.kernel.org/lkml/20221201135110.3855965-1-conor.dooley@micr=
ochip.com/
[2] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE?pli=
=3D1
[3] https://lore.kernel.org/all/YxIzgYP3MujXdqwj@aurel32.net/T/

--=20
Regards,
Atish
