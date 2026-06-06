Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100D318146
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780782468; cv=none; b=sB3hJSA9bb5MuJZEyWXGjJVLaFXl/CjCnAItP5M+AM+tAH8bzhlyDTIdn/sa/wortiTV52HzlXH3nnxWZ+UQi5BmlL84CXyewamw2wgexNU1Ty8o1JDcgxKVhOej/+5RlEQhejjk59RaPJ7XTE1dEmTjQJfgqzwX2Z8tKEnx3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780782468; c=relaxed/simple;
	bh=VGNia2i+xsmFO//wEAhSljOQ0OTS6fqEcGSMHk++chw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=n4APJHalX1Po1AzQg0EmjqgQ3/8W4kCFvLDCJrEpOORgYGnwclJEsmOxTuMJrpQ7rWDqZ3B6fMSDrbDz68QYROnnaA/k7gjWmrEF31fxykgjAuICpgFuDKblu1SEGT7i4QIB20kVPv+K3K2+YY2YErKsgMIsHOAfoGHCjv0QpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j86TuDv0; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j86TuDv0"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13721dfd471so4073655c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 14:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780782466; x=1781387266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=knAhyW+pB04RzwII1PEi8/COayGb1Z7ctOCyHMJc4zo=;
        b=j86TuDv0xfSKxdLZXW5Us7FQGFCKeqeYQ/FkqKWW2pX8ca2EslDO/K6JrXxrh1y9gP
         c2zdefSH5N4LBiS3hlsp+nmGyLPb8uY6WUeBnGg3qR8/ggJUQk+YVwUNGNTmfTuo5/7c
         aCc1GqXVnH63oNj1PgR0YW2Gv7w39JHH42H0xEM1ok4w9rELC0IBqlDxvJAcpH9g1P7g
         yrxlR/XmYX6i6DfnUjRZnzs+hfOvZ2brVCQoAE2iVnzgFGBt74mleGitTS17jeRNxP8h
         5IN86ukh8XKjsAHEv75QuDtOa/RyNu5x1m55Nadigcj70JGdDy/t81O8pJACythEVwAj
         O+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780782466; x=1781387266;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knAhyW+pB04RzwII1PEi8/COayGb1Z7ctOCyHMJc4zo=;
        b=rrMTCSAoVP6G1xNKQZeVD+Q2q8zv77/mdB74yAI7mMPLzFRmURcQzhszBK4uA6lV3M
         DTC4fsk9+/kL8YjBDJ9FnoGbPJIjKUd42HYGiMPSq+hwixAwVBaZ9O6I4uIL80cWGSKs
         I48y5qaCW+wyELDwVjaF/I8Bh2288Y7c3f9XAtNpkA03dS6brLs71McOJv3ryZ9x6gmJ
         2dWLF488abc+qnaV2IWPqNb8ImBrRUkYNeK+z6mQ0TiR5Qf37TZbjqxOGcTUhohGD/PF
         q/UcS5wxWzfyzE2jr954a0Qqzj0B1LAAdHgd5PJkjCcRMHza+pDrBe2I+bF8tyJggIAO
         tNCA==
X-Gm-Message-State: AOJu0YxQ16UaIGCQM0o+GxXcdfFs9n7ER3uDB8ZHMeuoO2j5rV4OR19I
	glXw/XCowjQZbSx/xdzlzAgQf/SIndJ0HTN2SrsfpszYiJmKm5k5OysH+HBJ0A==
X-Gm-Gg: Acq92OEgdnnuJk9ssNuGDzZev546iPmy0z8kNdXl9L5cqMXTolzfyILGqOzGHlEcFIt
	wvWmsHLZLmvnPdNAezCj2IndJUeiIVF9P13j5EaJfk6dPqyv0ABU1TdoO+q2UiUKFjx4f0VRYII
	O28Sc6/Yd8e7MJSUJibY/Jgt8+TdBOYDMGwa6ay/MNGKA4HZGv/IF+hrpyV77C2hwe2B1USZrGI
	Lr0fJj2VFthiSNC6PETZZuLQZ2TzqineXaXlO8SK7NUpugCesYtwhf2Z7+EblzM0YgdGPazQajB
	D1a0//ux3huU0nCT0C3glXDgAD+qMiRIZeaH1VyJ6cX7pVxrRIgnw4ZTY9dqM+WCZrpTpaKjnrA
	mLzCccNaVblfAwxkBPO2X1S1WOqb+O4HEn7+hMJhfUfWbTfZGHuKCROFLtoTsKKTDttXo2UkahL
	MVsrrmDVPfsX2eRKIjuq5wM1snh4k0gWQJ65kGU4q+Caj8zhf6xqY=
X-Received: by 2002:a05:7300:ca4:b0:304:885f:2db0 with SMTP id 5a478bee46e88-3077b22a7demr5774015eec.20.1780782465662;
        Sat, 06 Jun 2026 14:47:45 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:b36f:a793:65eb:7bcd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54c9c12sm8887001c88.6.2026.06.06.14.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 14:47:45 -0700 (PDT)
Date: Sat, 06 Jun 2026 18:47:40 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: linux-perf-users@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/7=5D_perf_stat=3A_Introduce_perf=5Fen?=
 =?US-ASCII?Q?v=5F=5Fget=5Fcpu=5Ftopology=28=29_to_guard_NULL_env-=3Ecpu?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260606202336.0F9321F00893@smtp.kernel.org>
References: <20260606200601.1861227-3-acme@kernel.org> <20260606202336.0F9321F00893@smtp.kernel.org>
Message-ID: <4E25032E-8AD5-4832-B776-0B2E22E5B827@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 6, 2026 5:23:35 PM GMT-03:00, sashiko-bot@kernel=2Eorg wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
>Pre-existing issues:
>- [High] Missing bounds validation for the untrusted `sample->cpu` index =
when accessing the dynamically allocated `env->cpu` array in `machine__reso=
lve()`=2E



One more series that has small patches and no issues from local and public=
 dashiki, only detecting (more) preexisting issues, all noted and being qui=
ckly addressed in follow up series=2E

Waiting a bit more for possible human reviews to them merge it and submit =
the next, that's already in the works :-)

Best regards,=20

- Arnaldo=20

>--
>
>commit 50d04a9b8194c04adf66854548c5855bbd4c23f4
>Author: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>
>perf stat: Introduce perf_env__get_cpu_topology() to guard NULL env->cpu
>
>This commit introduces a safe accessor, perf_env__get_cpu_topology(), to
>prevent NULL pointer dereferences when accessing env->cpu on older
>perf=2Edata files=2E It also updates several topology aggregation callbac=
ks
>in builtin-stat=2Ec to use this new accessor=2E
>
>> diff --git a/tools/perf/util/env=2Eh b/tools/perf/util/env=2Eh
>> index 7621d1f73b83a=2E=2E7acca39b42ff3 100644
>> --- a/tools/perf/util/env=2Eh
>> +++ b/tools/perf/util/env=2Eh
>
>[ =2E=2E=2E ]
>
>> @@ -187,6 +187,20 @@ const char *perf_env__pmu_mappings(struct perf_env=
 *env);
>> =20
>>  int perf_env__read_cpu_topology_map(struct perf_env *env);
>> =20
>> +/*
>> + * Safe accessor for env->cpu[] topology array=2E  env->cpu can be NUL=
L when
>> + * reading old-format perf=2Edata that predates topology information =
=E2=80=94
>> + * process_cpu_topology() in header=2Ec frees it while nr_cpus_avail r=
emains
>> + * set, so callers must not index env->cpu[] without this check=2E
>> + */
>> +static inline struct cpu_topology_map *
>> +perf_env__get_cpu_topology(struct perf_env *env, struct perf_cpu cpu)
>> +{
>> +	if (env->cpu && cpu=2Ecpu >=3D 0 && cpu=2Ecpu < env->nr_cpus_avail)
>> +		return &env->cpu[cpu=2Ecpu];
>> +	return NULL;
>> +}
>
>[Severity: High]
>This is a pre-existing issue, but I noticed that tools/perf/util/event=2E=
c
>accesses the dynamically allocated env->cpu array without validation=2E
>
>In machine__resolve():
>
>	if (al->cpu >=3D 0) {
>		struct perf_env *env =3D machine->env;
>
>		if (env && env->cpu)
>			al->socket =3D env->cpu[al->cpu]=2Esocket_id;
>	}
>
>Since al->cpu is derived from the untrusted perf=2Edata file payload,
>can this trigger an out-of-bounds heap read on env->cpu[] if the
>file provides an artificially large CPU index?
>
>Would it make sense to update machine__resolve() to use this new
>perf_env__get_cpu_topology() helper to ensure proper validation against
>env->nr_cpus_avail?
>

- Arnaldo 
