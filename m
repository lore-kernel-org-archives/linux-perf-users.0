Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9992361977
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789301714; cv=none; b=lzOYVS5mM6f7bdmVAnarEzA7RWvs6OD7Y7GdF3bcH0FF6xyKJevXlcdPpAFLcRmHjtsW/H/RTIvbxwfwcW2ijBC+XDDVXYbFwxXTmsPlKxRqEQa408j+xxXL0KHNQYJIAM5PmgsSmCcgLDbRj8meQabaf1Jk28Tmh6PJz9JO9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789301714; c=relaxed/simple;
	bh=hKysyXX2c97twHFT+qB2lQTPpAk3w8xncJ/PJIlGA4k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pi5jnnuZicrIuZa5mwaWe/3S5L5Ycg7em39HaXz/3qbn8iGElOgT+nulp6ZUU6YN0pce1+nsdOr3PNtQbLqWBBNhuhMq72DAFcbP56Pronu6HpfanKOu+i21AkFJ3ut2h34q8T/DRkWNhk4S4ihR+iVdBtwNF1N8StOEgxRX9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1MIYtY9; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1MIYtY9"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b35611so467660b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789301712; x=1789906512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lSoM6I1aPz9Shou4iumBlkD4AmDilJosmX4TmWduFSQ=;
        b=B1MIYtY9UMmDxDdS2UGGZqQ2xckz5y7Mk1tDwQsXB4RR/vTz/DuPA0i2hJn8vkCzPy
         UJyiadjJVP5POqlab8Nf1jdCKxoGlD0Oa5hQ0q+pjm/+Stblr6qoeVYnGSXWzeeEsqGI
         hUlX/4DKBs5D75OUU1db1ooCBFzU/KcCOIcJ83waYVlHUpueceNljezw2ZFxD+sbRUjd
         bcQuHW2iQ3Nybe4S+8NEp2YgjzDcmGFZCj+913gBDqm7uj2e7agSfarfo+zO/kFS0cA1
         sX6ho6pnY9GOtr+/fU+6Nl31RDl+R0z4ZkrTl1SZIBt1qnZYH0gBeRR3cOEydl+tZcno
         cDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789301712; x=1789906512;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSoM6I1aPz9Shou4iumBlkD4AmDilJosmX4TmWduFSQ=;
        b=OqI082WD24lzb5CTb/NAfsmc7V2pTp4rvlcpOxjUozZikSGEUpMwVHeFzLswEUb3sz
         NIcM3nzmfkHtqCNvuGwHcfmORu1cTKHcq+z9NbrzteBPIeobG/J93uRUcob0OgrbrnVx
         QJeZ2PI6Cg/zlOm8nOjuo1fOAKtZ0rBtTAYAGA01iXM/bTGzJhjKcN6rihA2ibrnB/bB
         DqigdK7+hFfgkQvINvJ9QcXwGJOjM4VPzCHl4Pqx+/xJiEzAR42X7Ce1P5uTQROuN9e3
         nIHDlQ63OkKfHCsLgZ/P4cJONbD3oLhm1sP0Jd94oIw3OzYULe+ylCZ33kBo2z3N362D
         SvPg==
X-Gm-Message-State: AFuF++l9UMvLszZeQ5NLvHAd+9IsTFuBGk082yfkl/GYpM39OqIsgJ6M
	KMOc1h97k2WV6yoaZZedcoUUETLzBYU393wZGYIGB8parw6YPZYAGO0zyhS3G3BO
X-Gm-Gg: AYBFou0ahJAru/yW6Nq6+oQnlMJKZXc6owwl0xmJIkDLYa3bYmWGS2ghfhKwA7yY+fx
	SiM+LDQSYpBcsT9GtLXOW+QsniRR75NZ5Ca9Zl5Kx/cxfzttjXST6/0JLIgS0Xvpe9DKCgANdwR
	hzWxtGGq4EqOshb7TJLQ0DtaRELl1kFB+4cK5mti0SvB3KeqkPuCPydjKcQgHpYauLXX21W+gMD
	bwsuVaBo7xHyJiZkyBeFHbcuyCy8GTulqpyDY116Ssd6qHx2mMohyIqmKxdlK3ns0Ja+y8LBtc+
	ShLBO0sEWZwXWTi2u9z41vg3qQA2Y7Rdw6S40ylrZwkLgVJsdD1m2a0tLQYE1hSQpTtrNx1ZMRi
	0bgBUjmd6XJKao4ebhg5y3YkXyEE4eBaCyzM7p+AhPg8aCQOuMtcLQ1RgdWJCWnNdCGNJgtN1p4
	ybrFKaZO4yp/JBUXWMOgcddG8mAAHFIgHcyggQIKxuTvVRmjlLM65JCKy+PCXNrKXO68rgqrdXP
	P/YIclFK3tvoSxl
X-Received: by 2002:a05:6300:670a:b0:3d1:af47:5f80 with SMTP id adf61e73a8af0-3db0e12bca1mr13678451637.11.1789301711879;
        Sun, 13 Sep 2026 05:15:11 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:fb55:7959:5b2b:8b1c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed64fcsm21871662eec.16.2026.09.13.05.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 05:15:10 -0700 (PDT)
Date: Sun, 13 Sep 2026 09:15:06 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: linux-perf-users@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/8=5D_perf_debuginfo=3A_Fetch_d?=
 =?US-ASCII?Q?ebuginfo_keyed_by_build_ID_using_debuginfod?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260913033651.5686D1F00893@smtp.kernel.org>
References: <20260913032632.116277-1-acme@kernel.org> <20260913032632.116277-3-acme@kernel.org> <20260913033651.5686D1F00893@smtp.kernel.org>
Message-ID: <F4EDF3EC-ABDE-43E8-A343-DE710D636211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 13, 2026 12:36:50 AM GMT-03:00, sashiko-bot@kernel=2Eorg wrot=
e:
>Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race condition in debugi=
nfo__find_build_id() leading to redundant network fetches and memory leaks=
=2E


Ack, fixed in V3, will post later today=2E=20

- Arnaldo

>--
>
>commit a2b8e0baf731e115b13a42e3b82a0348a1a8851a
>Author: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>
>perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod
>
>This commit introduces the ability to fetch debuginfo keyed by build ID
>using the debuginfod client when it is not found locally=2E It adds mecha=
nisms
>for progress indication, user cancellation, and caching misses to prevent
>repeated network fetches=2E
>
>> diff --git a/tools/perf/util/debuginfo=2Ec b/tools/perf/util/debuginfo=
=2Ec
>> index 84a78b30ceac1=2E=2E6f3023c96375c 100644
>> --- a/tools/perf/util/debuginfo=2Ec
>> +++ b/tools/perf/util/debuginfo=2Ec
>[ =2E=2E=2E ]
>> @@ -139,6 +149,443 @@ struct debuginfo *debuginfo__new(const char *path=
)
>[ =2E=2E=2E ]
>> +int debuginfo__find_build_id(const struct build_id *bid, char **path)
>> +{
>> +	int err;
>> +
>> +	*path =3D NULL;
>> +
>> +	if (!build_id__is_defined(bid) || !symbol_conf=2Edebuginfod)
>> +		return -1;
>> +
>> +	if (debuginfod__cache_disabled()) {
>> +		pr_debug("Build-id cache disabled (buildid dir is '%s'), not using d=
ebuginfod\n",
>> +			 buildid_dir);
>> +		return -1;
>> +	}
>> +
>> +	if (debuginfod__missed(bid)) {
>> +		char sbuild_id[SBUILD_ID_SIZE];
>> +
>> +		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
>> +		pr_debug("Not searching build ID %s in debuginfod again, it was a mi=
ss earlier\n",
>> +			 sbuild_id);
>> +		return -1;
>> +	}
>> +
>> +	debuginfod__fetch_lock_init();
>> +	mutex_lock(&debuginfod__fetch_lock);
>> +	err =3D debuginfod__fetch(bid, path);
>> +	mutex_unlock(&debuginfod__fetch_lock);
>
>[Severity: Medium]
>Could this introduce a time-of-check to time-of-use (TOCTOU) race conditi=
on?
>
>If two threads concurrently call debuginfo__find_build_id() for the same
>build ID, both could check debuginfod__missed(bid) and symbol_conf=2Edebu=
ginfod
>outside of debuginfod__fetch_lock=2E=20
>
>After the first thread acquires the lock, completes the fetch, and record=
s a
>miss (or processes a user cancellation), the second thread will acquire t=
he
>lock and unconditionally perform the same fetch again without re-evaluati=
ng
>the conditions=2E This could lead to redundant blocking network requests,
>ignored cancellation requests, and duplicate entries added to the
>debuginfod__misses list=2E
>
>> +
>> +	return err;
>> +}
>

- Arnaldo 
