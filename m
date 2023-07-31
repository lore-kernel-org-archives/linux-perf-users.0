Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD47C41513
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Jul 2023 21:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGaVHs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jul 2023 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGaVHr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jul 2023 17:07:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687F0194
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 14:07:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so17707005e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1690837661; x=1691442461;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNCGPjrbiEcyOtFfnoUVJfAnHPG+PuJqCkOivI0dKrA=;
        b=FXyIWqpqhN+jTLM7VoB9X8KH9YGhO3BdVRbPbL+PqDUSp4+sviIuBIY/Rvv02m/PBA
         OnULbqTAvH7W4XDTR6e8EQa0mMDiOhc4hPLf94ek9tER+nUJ74XdGiM7Hgjlhwp5TGsK
         BHCfbC1lvxYVlSsXlfSDvTe2mgW/GDyVERsPc0MUkS7KSQvhSG0+WvVDNp02prlogtz3
         U6NjH3bUOIHxcNto+k5TNole3bbMs0gx5RIibAPmBjwg/8GwthgOZzOPFo63b4htdzXM
         lZJtxm13vuKhLuqzyzJC8ldXvCiFLon4KJY1ATFOEgtSl3IGVU3+3Z9vPHPWtu0i0gae
         bjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837661; x=1691442461;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNCGPjrbiEcyOtFfnoUVJfAnHPG+PuJqCkOivI0dKrA=;
        b=f2yVGLkYJiYyHIpNAqTeN7bEor4xMOin0QZKwa+BFo91HgAKT+DlVXNiUEzRDZGkJd
         Ba6mZGxz88t8aOYHfYcNDPF2RTVqIlP420Ecy7sfrZT7R/BmOxwTfr/4NgRw+rO8X7+t
         SATkGtOxJwOGI41YSpW5uBJeU2L6HrglgquNogmYdVKuNustTaPwejONNLKd+vdXBxO/
         lhg8vdWosI8J4Uea4OBoa9Hi79XhBcRq8DsQiurBTMGe0vucPTdL/Mpq97MWRtYB379H
         m1eb3ljntpcaU45i8CS9Gpbrui6zMJOw796ErNJ4C6P42itqRuuxuKOKEUGuFo0ONucm
         vLCA==
X-Gm-Message-State: ABy/qLYbFTFIJtFMaqyMiw8u5aoq69eCZ9ZU9ISYqf2Zpbqwy9uPI+Dc
        HEyYjrddoYXMjT4mCnfmZapVpg==
X-Google-Smtp-Source: APBJJlGHTwVNWd//PZQ9JNGaGWYFnzIoYEDoehkWWJ7bscA0fSlZcXrSVnZcugVxt0+DshWg2nS0QA==
X-Received: by 2002:a05:600c:2213:b0:3fe:2102:8083 with SMTP id z19-20020a05600c221300b003fe21028083mr741960wml.26.1690837660761;
        Mon, 31 Jul 2023 14:07:40 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe8d1000000b003143867d2ebsm14090234wrn.63.2023.07.31.14.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2023 14:07:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <ZMgP6hhD/k7QNQ3t@casper.infradead.org>
Date:   Mon, 31 Jul 2023 22:07:28 +0100
Cc:     Ian Rogers <irogers@google.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Brendan Sweeney <brs@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?utf-8?Q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Atish Patra <atishp@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A8F40EA-0322-4E52-B806-AE93B5D7CFAE@jrtc27.com>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com>
 <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
 <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
 <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
 <CAP-5=fWwzuGZ6a6Z38ndsb7gw7_uwS0a2VGXx08hMeiK8eZ91w@mail.gmail.com>
 <CAHVXubjhM9C1fw_Us=8+RuSJbW0pacFAk9gp7j2=BtMUPy_Byw@mail.gmail.com>
 <CAP-5=fUbiaVwSAhTbymyhdUPcVAXHiQZZexAOnrqid0LsPmfpw@mail.gmail.com>
 <ZMgP6hhD/k7QNQ3t@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 31 Jul 2023, at 20:47, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Mon, Jul 31, 2023 at 09:46:07AM -0700, Ian Rogers wrote:
>> On Mon, Jul 31, 2023 at 9:06=E2=80=AFAM Alexandre Ghiti =
<alexghiti@rivosinc.com> wrote:
>>> I have just had the answer internally (thanks to @Brendan Sweeney):
>>> csr modifications can alter how the memory is accessed (satp which
>>> changes the address space, sum which allows/disallows userspace
>>> access...), so we need the memory barrier to make sure the compiler
>>> does not reorder the memory accesses.
>>=20
>> The conditions you mention shouldn't apply here though? Even if you
>> add a memory barrier for the compiler what is stopping the hardware
>> reordering loads and stores? If it absolutely has to be there then a
>> comment something like "There is a bug is riscv where the csrr
>> instruction can clobber memory breaking future reads and some how =
this
>> constraint fixes it by ... ".
>=20
> If the hardware doesn't know that writing to a csr can change how =
memory
> accesses are done and reorders memory accesses around that csr write,
> you've got a really broken piece of hardware on your hands ...
>=20
> I know nothing about risc-v, and maybe the definition says that you =
need
> to put a memory barrier before and/or after it in the instruction =
stream,
> but on all hardware I'm familiar with, writing to a CSR is an =
implicitly
> serialising operation.

satp has some special rules due to the interaction with TLBs. Enabling
/ disabling translation by toggling between Bare and non-Bare modes
doesn=E2=80=99t require any kind of fence, nor does changing the ASID =
(if not
recycling), but any other changes to satp (changing between
Sv39/Sv48/Sv57 or changing the page table base address) do require
fences (not really sure why to be honest, maybe something about having
separate kernel and user page tables?..). =C2=A75.2.1 Supervisor
Memory-Management Fence Instruction of the privileged spec (the one =
I=E2=80=99m
looking at is version 20211203 but dated October 4, 2022) details this.

Jess

