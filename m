Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475538;
	b=O/krLO8aGenUXW/HQEOWJrDwElStiEb4fMVpZXUNZTZHeQxpP8E7J9EgFAslndG4DsPH
	 h7ZsHfFTF2PchuW2NrGcbkfgDsF27H0BUGpI6bqnmP7HfiDKLAL38P+L3DdzDO7BS/ORS
	 u+ag/LQjMm0x4le0LKCzsRnJ7PXynKzc+w3vWVCboH9SG+75V0frUdxk8hZ8wEKI43++o
	 ALq1ST/KsowIoAE+6V4pCoa+L7L11yCYUBQQOBzoXXxIPi8zerBwHqGtFugRWi5aIgfI8
	 I9Yf6X16a+eYoOibUu8BYi9LYw0fut7tZr/OLCP+bzY7OTZoXbfBrMXUUUx7MgX/MMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=mOR5XNAvie017VEy/fECZY/fsMRjpYtJyEr3mhAIilo=;
	b=M8JLJpLE3VAG6+PJXhaoqbQLchlk3xmGKtesg+DEZjp1t0LfuHx8cMVvCTLrPYJpuYcH
	 sPP3BaFZzYo5QIXTC7ISNSLZDvAYt7USChSQus84xEijrvN9AHdeS77lbZknx0JG0LQPl
	 7zROOvuy+pvSAfb/m9Z2xacG4LeKOuaEfbaa2rC+d9ScvNZyMe5qB+wbU8/QfIOQFuqC1
	 yxYFNYrWhTj3KAluaQ/0jsYFk2FYeGWf/Ze8ep3bIJc2ikuIEQJ9tqcZdUjF08w/6m231
	 vrKdIllV8VMG3pUjudEZkEg+yqUpTfsMLK4tDFLfhBMTAjy/AfYBxfpHJeDsWhO0O7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="z/c+wUT4";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C1606A6A3
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 23:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 647C1606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/c+wUT4
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a315ed211so4877874eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 15:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795475537; x=1796080337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mOR5XNAvie017VEy/fECZY/fsMRjpYtJyEr3mhAIilo=;
        b=z/c+wUT4E/OeX5GjJ+Mhci/RNv73KgJlGX+200xEf2y+K8jeSXG4NXnAw/7HdXec17
         rpp5R4KDyB/dWAJpvdYXMLQCGFk58uiQIHOOsLUy434VpMvxJi8CXFdjeuhMQCQ0jzs4
         tfMTN2zdcwXA7aiW0jHME8F8ysDsIsOsUNxjI728keOSTsSv8OKv6U+YYSEiUffRO2X6
         D00MW/5aPk6+XrVN01yaO2RilcZvkg6iEdkTsIvB+IaW2JIpq7cjs9PuyShIT9VgyzPB
         nvbRC8D2r1x7WWu7xaTRzmEk+sore10X10NAvVCZNHvCLO5B9LfV8gva2K3BoFA2Exew
         iEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475537; x=1796080337;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOR5XNAvie017VEy/fECZY/fsMRjpYtJyEr3mhAIilo=;
        b=GCHMgjZoIIYGzgMlyQwSz14cKIKtRryM5zREkZKm9L5756rWf4zpYcuXZFkWFjC5sc
         p5ICFsFvYuhGZVjuyPKLyRCS9WHwbFPSoDf+RVbzTKAPNannEcsG9WRaV2xK+ds0nWZN
         VMrwiMYBtMjl3IN+wsUBxpVdngERJcNXCXstyTUT74YtfJY2Ilbri48yj7qiay3m8cKd
         H7lkFtAMRalbjhxPKGA2RuGyXKhXE0jz/l97ZyZjlyK7ht9nA501Vcxm8QcNU31+SPes
         on/J7zTNgL/Wr+hVtUBIEQChExfGGM2flFSViQ6HRWfilACJiHzNf50le35q0RbrEHgA
         k9AA==
X-Forwarded-Encrypted: i=1; AL+hErG+6Yzkbl0aX6caHK4zI5XP/vuUo0lo6JEPrjOBPLdpkijeQ7URgAHJxkTKeAW7c/UGzWPlKvcczCJ3evzzErXx@vger.kernel.org
X-Gm-Message-State: APuU4Z/kh/017lnj016Z8oSsA35Bi2Is9ZpwY/79MbHQj2O0KsPhxcFY
	6PtEt6UUJAV7k+y6DP+sqxG4OO6JGk90wqb/W87VRCTgxkep5ZhKm7qn
X-Gm-Gg: AZFdTZd/k2RsXpi0l6YvhqVH0u+gh7r3W34sw3aLoJLOIxuBsrwuYSc9mUE5vOREgcS
	SvH+dscXvOUdVZRHckQKhLSN7Od8f0pSrNqnOTZubUYCp1pveC/rfSPpVAPhfq0k96mATm12pNc
	pPz2H0xoI8nvQkegrXJlUsw7lpdVj1MQGK77T1AUho6E4tjZ7LmHwE/UVScUQhYFxavMLiZKM6/
	a5SgCPOvhdXFR9PyIUEfdT1s6dtwyjzgc1AmFauJn/0qBCnf4Gp1jrKLHGWjHb9Jsc0LFAIlD4L
	AG4dbwnWUp9SyGNrHasNKafjvu27iyy8kL7sMNiXNOrWyzQoh3kPm+FBmmWz8dwz2zkRktEbhg3
	eEdfkJy+7qqA/EB+i3TfMLWYT6jVNdQS954FWHc5AM3pTIIDu4pkriorx6h69mliyI0XmILrt6f
	MYR42dkBD/Pu363qWpvjcl5Fik3AstkNdskntas3Eu45FVHQ5aEuNM7betV2rnRVeMPiV3//0wG
	SMr+3oJoNIytDGbCtXmIDVsb3TEfp0RZmeOVFb79JVFjgle2/yGzMchTvIk+UIGUDdT50ozScIf
	60lGzPuSTC1mraCwK4Idj42IrA==
X-Received: by 2002:a05:7301:7309:b0:382:2ae3:b1d0 with SMTP id 5a478bee46e88-384b3e788a3mr15285209eec.13.1795475537081;
        Mon, 23 Nov 2026 15:12:17 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm67931661eec.3.2026.11.23.15.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:12:16 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, Song Liu <songliubraving@fb.com>, Hang Zhengyang <hang.zhengyang1010@gmail.com>
Subject: Re: [PATCH v1 06/13] perf pmu: Don't treat tool PMU as a kernel software PMU for event grouping
Date: Mon, 23 Nov 2026 23:12:12 +0000
Message-ID: <179547553247.235629.15166017818384644106@gmail.com>
In-Reply-To: <20261123071913.653315-7-irogers@google.com>
References: <20261123071913.653315-1-irogers@google.com> <20261123071913.653315-7-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Hi Ian,

06/13 keeps a group that mixes a tool event with a kernel event from
reaching the BUG_ON and the group read; I am not disputing that.  What I
want settled is whether such a group should be split or refused.

The 06/13 commit message says:

> Return false for PERF_PMU_TYPE_TOOL in perf_pmu__is_software(), matching
> hwmon and drm PMUs, and ensure evsel__compute_group_pmu_name() only
> substitutes perf_event_open PMU names for software and AUX events [...]

I took the other approach: perf stat refuses a group that mixes a tool
event with a kernel event (one that perf_event_open() opens), unless the
group is weak and its leader is user_time or system_time.  With that patch,
perf stat rejects -e '{user_time,cycles}' with "A tool event cannot be
grouped with kernel events: user_time" and exits with status 22, instead of
printing a value for the tool event and "<not supported>" for the rest.
This is v4 of "perf stat: Refuse a group mixing tool and kernel events":

  https://lore.kernel.org/all/20261122085947.3107661-1-takano32@gmail.com/

In v4's test, the -a case expects a refusal that the cpu-map split in
evlist__check_cpu_maps() makes impossible on a machine with more than one
core PMU.  Only the test needs to change; the refusal code does not.  I
will post v5 with that fix.

The parser's split for events of another software PMU, and the split -a
causes in evlist__check_cpu_maps(), are not what this is about, and I am
not asking to change either.  The -e '{user_time,cycles}' case is not a
regression: perf stat opens it as one group today, the kernel rejects the
cycles member with EBADF, and cycles prints "<not supported>".  06/13 would
count both, as two groups.  I would rather be told the group is refused,
with a hint at the form that does work
(-e '{cycles,instructions},user_time'), than have perf choose a grouping
for me.  That is a preference about what the braces mean, not a claim that
06/13 is broken, and it is yours to weigh.  A warning would tell the user
what happened, but the two groups would still start and stop separately,
which is the part I cannot square with the braces.  If a warning is what
you have in mind, say so and I will take the refusal off the table.

With 06/13 as posted, the tool event keeps its own PMU name, so the group is
already split by the time perf stat's check runs.  Moving my check before
the parser regroups the events would refuse a group over members that -a
would have taken out of it, so the check has to come after both the regroup
and the split in evlist__check_cpu_maps().  If 06/13 keeps both changes --
the one in perf_pmu__is_software() and the one in
evsel__compute_group_pmu_name() -- the groups my test expects to be refused
would be accepted instead.

The refusal does not reintroduce the fd == -1 case 06/13 guards against:
the check runs before perf_event_open(), so a group it refuses never reaches
get_group_fd().

On v3 of Hang's patch, which I posted for him, Namhyung wrote (2026-11-20,
<awC_aZXD5FBGu4mO@google.com>):

> I think grouping with tool events would cause more headaches.  Probably
> the simplest fix is to prohibit grouping.

Namhyung, by "prohibit grouping", did you mean that perf stat should refuse
such a group, or that it should count each event on its own and print a
value for it?  06/13 does the second.  When I wrote v4 I read you as asking
for the first, and v4 refuses exactly those groups; a group of tool events
alone, such as -e '{user_time,system_time}', is still accepted.

07/13 ("perf evlist: Enable tool PMU events when starting a workload")
fixes the enable_on_exec case my patch does not touch; I would like to see
it land regardless of how this is settled.

So which should it be: the split in 06/13, or the refusal in v4?  If the
split wins, I will withdraw v4.  If the refusal wins, 06/13 would have to
leave the PERF_PMU_TYPE_TOOL case alone in perf_pmu__is_software() and drop
the PERF_PMU_KIND checks in evsel__compute_group_pmu_name().

If you would rather leave it to Namhyung, I will go with whatever he says.
I am asking you because 06/13 is your patch.

Thanks,
TAKANO Mitsuhiro

