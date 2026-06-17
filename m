Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12637EFF4
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737195; cv=none; b=mG3o8cvT6HK3jQwbAnBl4rHQ7+kCf6uSxNQe2zMexagYwzsWWs09oTmvNGA/Noetve/5UccPIEY1JXMxVNlvlyYe/vS6X92wvb8Fh3ZbQKGup1DQlArvmDjfjpVkKQdn8IGh7UOXqpCNBsXxTGeUVf9DzvLNg7KddIutOY5jjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737195; c=relaxed/simple;
	bh=7j1+9fHqVc3E3CdfBPKfK6sDQjl7/oECFRzMdgaI8jU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DQ6m0vPkqWRZWhJrpGK+HFEB0oPYzmkRZ8LsjXsLdgf36F8Ow2Z5i0av3dDGrBInTEW3fGIJkNYDuX/V9oFsdrjvUSwoDEkuu6anhfV2Px6d6Z5XGqtUROUUxM/WJ/GPViQ7KAapZPC/bqjsKcD0Kz/B1MSfZPzAmv9NDTvbqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g751uldq; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g751uldq"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bd445db39so124623eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781737193; x=1782341993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LTr+KvtLym1+4doSm6c0+5zv9b7Oyha7VC84op+BDLA=;
        b=g751uldq88gCT/K9ED6YZStfC0UDq7XljEUvSCfPA0lcmDpVnGnAFvfe+W22LyC7/E
         nlw+yqVZ+CsqDqyyscxsdNGwMmM9+nkSIJFj4FsmPHDAGTJf1fnTX03gG5JkQY+91BpG
         WxEWgT/b5MuhSatf285njaNOOtjA892cWSwuR5ZMwK4CuhNzOG58Vk29Jj5R9F1NKena
         6RY+B6VYsFTVcyMoKpB9i1T5aJhkZD7HzNeNnjo9iKJf7cBFeTicZKOl5lr19wjAJj0F
         9QgNANxIogd0a9wpv8Sar2bNtHCPbvZzu/ajt1r7SeQXadPvm8Tu4EwwNXFgwVrx6kE/
         SD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781737193; x=1782341993;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTr+KvtLym1+4doSm6c0+5zv9b7Oyha7VC84op+BDLA=;
        b=YxCnEhquyMk0sPXbZj0k9V3w0PJhMCDl0tVpG2sWY4OFn4J2DrUnyBVCAuY/sScArm
         Wv0I2TC3jv8lBkPNaPNFNxB1ttuVzzYDDXbznaD48oJQRzE1LAgz/E3NsheUcBO/rNuJ
         FQnvgnW84DwFuTmNGlYk7znuRH5tIXQHEKxMLcKeW/ksTaPQ3nTAWKZkh5ziN/Uc2Js9
         4rb/qZdFGwXnKqHn+pR3oIVkoUIc8T3nygX3KCnm3dL8e+ovMPVCAXMA6XnJf7G5/bFd
         avFiLPZ32bUPpohhd8ijaTbzQaRwM+isQpxL4Xig2erukqysGUl7kn+F4iaVgQNQDvIY
         iSJA==
X-Forwarded-Encrypted: i=1; AFNElJ+PG9DW+9jABB7G2kgC+U3d2vU3CdM8BiGZrxcVV0qdJCrMNKW55KgJjJzoIBWQC0V5GiF7f7bBRlk0EesQOPg4@vger.kernel.org
X-Gm-Message-State: AOJu0YyzPU262cCuWum9le+btS96H3o3X1XhZ6vFFD+bKeB1osu0hl9P
	XV+CZyTlBx/pA/sERsp+8ip1Xb+Wz21JlSDI1Hs+NYoo+aI0kz5zDP+jrozjKA==
X-Gm-Gg: AfdE7cm9c0VHJA+J0bBgTt0R9rGrN3ft2Tf1uHPo1ATkne8+K6RTDZMUHXNNNZz14vC
	rPH4kmNCSb3Du5gYajlfUl5gnZcq8Pz5wJIjdCAQ3A5oy39mvzFuBDdkUxAcFykMi16Ng8YO4Uf
	ynE4Dw1W3bWYoci6wxZ46gAzpgwqVYs8DefCH7nFu0MBO07gqgwGWrPQHQzE/W91vZO1V4G8O32
	51knbc14xFNoMm+OKF+Vks9M5aOIv6tx+QvhHhnnCM+uRmSSThP5nKq7BGTQRkPQTxjVqNjQC3i
	HhvtIyi1Wwh+LRcsfMEMuiAmdxO68z5LRsTIIsT7qpvdcvw1A5n82JjjiMSHsoCpCyXptznVjGx
	ygUbojMQL2CHUmTv7kMNw8xTsYJCWLUEPhjrur2wRnILSnNQ5FpjBCoh7jeoiTSRDRFAN5Eha5n
	j80FZ/iBKtsXQdcdW5qudeJCzxlV7VBL5ur6FyLF61
X-Received: by 2002:a05:7300:e52f:b0:30b:b4b5:4979 with SMTP id 5a478bee46e88-30beddd707amr571598eec.12.1781737193439;
        Wed, 17 Jun 2026 15:59:53 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:d4f2:c34b:edd1:35b6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0357sm22460208eec.11.2026.06.17.15.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 15:59:52 -0700 (PDT)
Date: Wed, 17 Jun 2026 19:59:49 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHES_v3_0/2=5D_perf_tools=3A_Add_?=
 =?US-ASCII?Q?cached_probe_type_detection_for_evsel?=
User-Agent: Thunderbird for Android
In-Reply-To: <ajMkLzJpXzyeqQh4@google.com>
References: <20260616182546.8892-1-acme@kernel.org> <ajMkLzJpXzyeqQh4@google.com>
Message-ID: <D7312D63-AC6C-4CBF-9DE2-B5259A04BA02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 17, 2026 7:48:15 PM GMT-03:00, Namhyung Kim <namhyung@kernel=2Eorg=
> wrote:
>On Tue, Jun 16, 2026 at 03:25:44PM -0300, Arnaldo Carvalho de Melo wrote:
>> Hi,
>>=20
>> Checking whether an evsel is a kprobe or uprobe currently requires
>> walking the PMU list via evsel__find_pmu() on every call=2E  This is
>> wasteful when the same evsel is checked repeatedly in hot paths like
>> trace__fprintf_tp_fields()=2E
>>=20
>> Patch 1 adds evsel__is_kprobe(), evsel__is_uprobe(), and
>> evsel__is_probe() helpers that resolve the probe type on first call
>> and cache the result in a 3-bit field that fits in existing struct
>> padding=2E
>>=20
>> Detection covers both PMU-based probes (kprobe/uprobe PMU, detected
>> by PMU name) and ftrace-based dynamic probes (kprobes/uprobes/fprobes
>> created via tracefs, which report as PMU "tracepoint")=2E  Ftrace probe=
s
>> are detected by the __probe_ip field that the kernel adds to all
>> dynamic probe formats =E2=80=94 this is authoritative regardless of the
>> group/system name the user chose=2E
>>=20
>> Patch 2 is the first user: it guards the __probe_ip field name
>> comparison in perf trace with evsel__is_probe(), so the strcmp is
>> skipped entirely for the common case of non-probe tracepoint events=2E
>>=20
>> Patch 3 adds inline stubs for evsel__field() and evsel__common_field()
>> when libtraceevent is absent=2E  These were previously declared
>> unconditionally but defined only inside #ifdef HAVE_LIBTRACEEVENT,
>> which was harmless until patch 1 added a call from always-compiled
>> code in evsel=2Ec=2E
>>=20
>> Build-tested with gcc and clang=2E
>>=20
>> Changes in v3:
>>   - Add patch 3: no-libtraceevent stubs for evsel__field() and
>>     evsel__common_field()=2E  Without this, NO_LIBTRACEEVENT=3D1 builds
>>     fail to link because evsel__resolve_probe_type() calls
>>     evsel__field() unconditionally (sashiko-bot)=2E
>>=20
>> Changes in v2 (patch 1 only):
>>   - Detect ftrace-based dynamic probes (kprobes/uprobes/fprobes created
>>     via tracefs) that report PMU "tracepoint" instead of "kprobe"/
>>     "uprobe"=2E  Check for the __probe_ip field presence in the tracepo=
int
>>     format=2E  Without this, evsel__is_probe() returned false for ftrac=
e
>>     probes, breaking __probe_ip suppression in perf trace for probes
>>     created via 'perf probe' (sashiko-bot)=2E
>>   - Widen probe_type bitfield from 2 to 3 bits for PROBE__FTRACE=2E
>>=20
>> Arnaldo Carvalho de Melo (3):
>>   perf evsel: Add lazy-initialized probe type detection helpers
>>   perf trace: Guard __probe_ip suppression with evsel__is_probe()
>>   perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__=
common_field()
>
>It seems you squashed patch 3 into 1=2E :)


I noticed it but accepted it at the end, I guess part of the process of us=
ing AI to speed up the process :-/

- Arnaldo


>
>Thanks,
>Namhyung
>
>>=20
>>  tools/perf/builtin-trace=2Ec |  2 +-
>>  tools/perf/util/evsel=2Ec    | 53 ++++++++++++++++++++++++++++++++++++=
++++++++++
>>  tools/perf/util/evsel=2Eh    | 19 +++++++++++++++++
>>  3 files changed, 73 insertions(+), 1 deletion(-)
>>=20
>> Cc: Aaron Tomlin <atomlin@atomlin=2Ecom>
>> Cc: Ian Rogers <irogers@google=2Ecom>
>> Cc: Namhyung Kim <namhyung@kernel=2Eorg>
>>=20
>> Developed with AI assistance (Claude/sashiko), tagged in commits=2E

- Arnaldo 
