Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6BA2DB795
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894084; cv=pass; b=S0S6uLmEXy/Cu5EUyHbfcHcaTDgCMX0rYeae7dXLL0TN1+uWI8CF4KNik2fdiAWi0JAC6ikKjhN2kLAwM7S5bYeBe22SXlg1kTPcB45RkA7ykcw0Vd8eqWJGmPaJIKMoiW51s28NpUKv88AfUsJSvMuQgu+v3HMifXKWfmrATSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894084; c=relaxed/simple;
	bh=1S7KybhQ4biGIKbQG0SRIZt3TWojX7DGxqn+dbeUDpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VahwkaYmfHfw4oJvl/bQ+icbLn+EXi6bwTbZzqWlxl0Fvps+529SWFf7+25x5/DolYcoWJWmoPveJFMVdzAsxu2B6UMg2irNcdwnaPvET56u4BmLoiShZLDKco46ng2E9PLMUiQkjpht18qMQcYZ/i4GGHWNB1ogGLS0b9g+/wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n59U2uo5; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n59U2uo5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f02651fccso4315ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 09:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767894082; cv=none;
        d=google.com; s=arc-20240605;
        b=VIohqSq4uClu+iqywg6sRjBEeeRGXufyFIf4Tjovi/JBma9x5esN+Q5fbf5RvHteGo
         yK0gEN33TiT1aTtOvspBVlGivhWnKvMPFtLzrS1YP4GvbD7rpb8J8mGeftCM8L1vjesk
         Qx7kI61zKD/Z6e14snVOXVd4etuHVukjEGvd1W3MKoCjzHwG5eiNzUO1fOoYObjliiRm
         P4QChgMB3DP6auWlRlrmyb/glOVY9nMOY81ubHshwcsHmJM/Hsc73ikxv/AB1yMatVHy
         UrPS79UluOC85zwAV/0xcRaStL8NPh7KA+589mLkA3wI2cQg9thsLJKD+tPrxtor+BOB
         dszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RQlzrAvOneW6smf/GLncdSCpRp54fZ272f0spNbj7sU=;
        fh=vTzpYrCn+7fs3hAL7qgcT9GYiPpYbaN57yoWzYRhDfE=;
        b=QDdCcsgVlV+aG2y7Fyxp140LFDQYA3bp+MdDhIk3qv9gF5EKtcKaoyLMFdE6LhTWhy
         6hzk3ggtKpqWHqn053GHiY6cYSu6ZsiqPVBveOl5xyvM39kjDHBo2AjY86uC6INzb9+5
         IkOKOsyP8Ti19jvbBBsfNGfEGmfXLq/M8wQQI3KaBt/8hKZ+kbTaAQS/hXGWm7E23dXQ
         68TGNnSsDxH2blCqi8DzBiOZfVtCgc85vaue/mbskhFBJOiM+0RxpgoChtOU9aw7g6h4
         xIx24Sq1BWVHjfTc5ojo5EfS3u45d9DZbSExSzvQ9AcjwAlEY8yB9eJlVMRASurmioeT
         n7Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767894082; x=1768498882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQlzrAvOneW6smf/GLncdSCpRp54fZ272f0spNbj7sU=;
        b=n59U2uo5eEJUB9PBHIA5WRcxzpM2tnalwOxOcn+E0ZbP54VSv2h6CihwF+lAF9KYL5
         CCqqkcRHR2uXHS3nhQh8NsLSPy0/yY9brjfIW2/94rNoHY3BK/TwWfPi7H7tw1Gk8XiN
         aLhtSA7tQtybqONY8eMA/9ctJU7UHsKkQHJLsY/LfeJExxJqSbTzozL8Kp7J1QVZDmop
         Ak85Osakei03ijFEaFTwqGbTfOBAPJ+xR9jNAAUp59qDNKGCmDqh7KTNvpT9MIw0Ayf2
         v+lyisqNSmD1HM92kAFD9eUPbWReNe4B7j+wuEZ+12J+yqB6Oo4w7SW0/0B7pkS8hVVH
         GlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767894082; x=1768498882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQlzrAvOneW6smf/GLncdSCpRp54fZ272f0spNbj7sU=;
        b=A4jMHUtLXFFVf41t3O66KVPZS2T+n6v8KFEKuiKBqKR7HY9FgJdviQ9+kIzezJo+Q6
         rDRkM58UZUVZOdkd7KU0/k/1s0fVT2qwhAii28GNtD8zQ+qCgT7YRTLGLjNlSdBJnfXb
         TO/HKkdfNAv6ps8p0yaPVt/y9d+iZjLq/s592ubaguKChBw9rTcSkMWOzqnFkVJ7kBbA
         VNN4toUKqchuFb0bL/iWSNSFUwCOuRHBU2LyyfE9jKQHfg939zz4TyUnDFxLpmVAaOc9
         CProSA7zNmmMfrQQdl9jrOACwsbIduusVbuuVpNKhMJuLATzaN+N+EvWi3A5oLz5OGsc
         EfsQ==
X-Gm-Message-State: AOJu0YzXuPIS+w5A/SwA2Y7EJyRP8mdlsiyl9ddgjgNIQ9/9RrS36YWI
	CTWWR6V3hjMGZQgwKnWFkTgPIY3a3RNG2SYVZlTbL98nqmv25k4pHEFKH24+rWaFs1FG6sPvQFa
	aX9XBXOZRq3a6GdOwMOzMWevuAE1j+ljo0T4orZ8jqJjkikmFwGwcJW/u
X-Gm-Gg: AY/fxX6JnnqJGG92s9zZ38ZAuaUx/mgl8r9/qIQxM31DMrQ+Z2dV+W7NvYT6osu2N9H
	we+FGcfgZ4zjbKs0lyBJmBJGhtgE64bZYjeceSwdSM+D1whkSWaNcPOEUNl55TWovN35F1g3uHr
	UhXnyQUKYcidmlECXavDDTKPbqvTU+yptdU3cbXLQnwx2vOL1TiJzmjBDwAgQU92xG9ALBBRKfn
	bfqsJR6dqCDcgxS/8SI+SKVsCJL1FxuASRxrZqJVHWe+7ESl072sXNM+G7xek9LwnM7wN1c+p0l
	VPLPL3ySaId+btzrAcZqoUDk
X-Received: by 2002:a17:902:f786:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-2a409a4dc29mr88685ad.2.1767894082143; Thu, 08 Jan 2026 09:41:22
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767858676.git.sandipan.das@amd.com>
In-Reply-To: <cover.1767858676.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 09:41:09 -0800
X-Gm-Features: AQt7F2pKrIsB-S4kCEVOg94bASbiDBHtQvB72zcw45LzuVAGlEVT9UpL21BvwWc
Message-ID: <CAP-5=fWYtPFNVFV2ZV=rWYrxgpU8Y3Ykc8BXsJpH+jDQK_J2sQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf vendor events amd: Add Zen 6 events and metrics
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:52=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Add events and metrics taken from the Performance Monitor Counters for
> AMD Family 1Ah Model 50h-57h Processors document available at
> https://bugzilla.kernel.org/attachment.cgi?id=3D309149
>
> Sandipan Das (4):
>   perf vendor events amd: Add Zen 6 core events
>   perf vendor events amd: Add Zen 6 uncore events
>   perf vendor events amd: Add Zen 6 metrics
>   perf vendor events amd: Add Zen 6 mapping

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

I also build tested and had no issues.

Thanks,
Ian

>  .../arch/x86/amdzen6/branch-prediction.json   |   93 ++
>  .../pmu-events/arch/x86/amdzen6/decode.json   |  139 +++
>  .../arch/x86/amdzen6/execution.json           |  192 +++
>  .../arch/x86/amdzen6/floating-point.json      | 1106 +++++++++++++++++
>  .../arch/x86/amdzen6/inst-cache.json          |  120 ++
>  .../pmu-events/arch/x86/amdzen6/l2-cache.json |  326 +++++
>  .../pmu-events/arch/x86/amdzen6/l3-cache.json |  177 +++
>  .../arch/x86/amdzen6/load-store.json          |  523 ++++++++
>  .../arch/x86/amdzen6/memory-controller.json   |  101 ++
>  .../pmu-events/arch/x86/amdzen6/pipeline.json |   99 ++
>  .../arch/x86/amdzen6/recommended.json         |  339 +++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
>  12 files changed, 3217 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/branch-predict=
ion.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/decode.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/execution.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/floating-point=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/inst-cache.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l2-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/load-store.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/memory-control=
ler.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/recommended.js=
on
>
> --
> 2.43.0
>
