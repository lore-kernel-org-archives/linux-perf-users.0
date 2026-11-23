Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425552;
	b=vDjXj8vbe219YZw1ugBVZJJPMeKSjnRKeaIV2rMzqIAz+dgBXnzmd2VwgJtOSBOo48qi
	 eu3q2s9ZC8n+ofjMJEzwPC0yHJc9ffpbgIKBiERIx9AsB1HEUdj0HRHEANdGmVl2ZdBX7
	 DTrws+pIy6fDAEw30tcT0PimsFNYuE/kNdtnHxkur1Ct67ZInyj5TkH/DjA6l8doCXxCL
	 UlvieG3N9hXAUZgdZGtFBJOrFPREJtQOAHPnBnp48KIwSV309kH+YKgeHsAx+NSqkhz8w
	 lGy2JzFsk+qaR3djUTeYmVkunyB+3eQMuRuZe/GsNBgPn2xUT3n3Bir5OcOfo106Slg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sAmqFpYWgjvb8G8xwJ3EyQTOMxtxvWPqiczFCJd978E=;
	b=cLzy4N4RZQnDYokEnC2T4dl6VFPL401cZl7UrZANqbPUKhZ5P5kvJlK7qpc8XAPgWgbG
	 42n6Ub7+SeB6+RDItJPD3+e8/2NEmA0KvZW4AIE0adyTM3BIqM0FQORz8HBdYAWYVhcvi
	 8BWUqF+F2dwQVkAPn0+gsMWzBHKiXXfjICtcPySKWCsBLVO7YwAOq/K8lDGzpemcIE8I3
	 LX5bmlJnpcOTBhHw/2nv3RKxIuTrEfrTktYdmXAnn0trtjn5NJ9IheizXzKppWxhSZJK0
	 Pqrxa2vF/GzHTxN/Ty09r+JUPxYbKCU4s1SLHATTclIOiVEXd+kPtIHPY5LsrlgOMog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aLYgqIqO;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCA606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 09:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35BCA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aLYgqIqO
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so2295416f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795425550; x=1796030350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAmqFpYWgjvb8G8xwJ3EyQTOMxtxvWPqiczFCJd978E=;
        b=aLYgqIqOlheI21nSFruPrybRyAxWQK7ED+fJlrli6T/LVj62UMse1MLF6+11EUrM/A
         5eDVZ6996LDJVUWN8t8/Dm2q0KTYUDv16Ej22VzeYkii835IVy5u8MPxw3I4LKz7BuVJ
         ZZTLl6CPuD3myzniwZ8AEPTvDe3gTHA1i9OCDKbi44OhiQK76Y7cgVfRHIyWV976Rsbu
         N99bZGzRPBKvh0ov7g50xkvhi108IuPeJp7XmScSqEZWB1GSxMqfZCDAt0Uryel+LpZh
         j+l+zxahWhmRp4+Q3wx7CgNawnVC4lfTxRdbSPm41nsN0m2BTT69RXGjns16maQDvpXJ
         uZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425550; x=1796030350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAmqFpYWgjvb8G8xwJ3EyQTOMxtxvWPqiczFCJd978E=;
        b=RnrJQAfw9QtXr90zWvGRnj++oQmT4564NWqZKSmwz/CpfEYeifwcBzma9rV555909F
         s3AXCYXYafSYJ8lfvxdC1rp2ia4djo+pgYDeVw+n8sAO4KFSvasEAFUJkkXu81mtWF3J
         5bdDDvViVUeybaf9edCJUBpOB5D/Ce0YxL+Y4Wz7zosr9kfo8tSP7Z11nuBLqjPY9+uf
         IkX0La/R0D18Rr+o0SnmBc3BcvP9xD3YK9pazT6YtVfPXE1H9RKVt2BksnUFanJaLTN8
         GCTTcPQr/LRp6MmZmN2ww/9f28EkjvU0Bra8q3hdw47Osm4m6CsqOhPJVBpQpfq5+dIa
         463w==
X-Forwarded-Encrypted: i=1; AL+hErHNwf/U9i6gdroolRUmYZylcC2okTH5NvB1L9wO0IG042kcM93mURuWT6hBWfHrg/z2yPKqLoWKRAnY0RR3hmEE@vger.kernel.org
X-Gm-Message-State: APuU4Z/eZjflotgDeAvIskDo7PG8kdk/4RKXTvw+tFb3o1Gd6GD65sm2
	qzJJXQpGNVllAw+Cj/imB8VSjnzvDg6l8Dpf4NH1oe6uwG90x2CPOq+ikC3kGFGm/YY=
X-Gm-Gg: AZFdTZcYYHBT3CnZZ2xQi5ePWBko4F4P6DdC9jiQ9fll5YJTAXcI6ZPp/k+P6PuE5GV
	E2O1mBPJ6SVXQpAVTDKUcTPDwZVDo5xu5cctlGwfgR6cP4e9kwJr5Dw7D4jBDqrrRyccdvOdacG
	Gz7x499E9C/uJxPVAC8/33FsfHCPi4u7FqAbFsE6dqVu1Z+5Z/fKkhkvL6RYaBRfkwtq6DxI986
	Png5HE0I7sSGC8+0YUbfCGoBaj3AgkbccuRcWpV60nYfmNSuTYbPUJRJYtT3S2+Py3nG4MGYJGE
	k2fzBKYU5zhDdosgQjbfUrwlYtJ2OOYDIKsjlaLDOVuZHtj0Q5Rz6b5IJAJBZL++YE+QechgEU8
	fzm1wEwBa6Vj5GxeG7GAq5pw3diiqoksn2DIDwdUqlNxFzlf01wbAx9//ESoExg7WxNS3BFfunw
	64+8drCBMXBca5RoLBz33roZ59SZwgu9Hbpr8a+eBBKn0I6vjC2SkJQyFer3QDNsuZcrNdCTc4c
	zzxt8Ohvd59k4BZOIA0dz/MRl4pJOKzx2NaUk1iRYSpJO+su4s/D6sQUuzNqTIaCE6hLMmwYWy1
	dMoSlPRGkvf2dBq9zFrs62rKv338gps23w==
X-Received: by 2002:a5d:4452:0:b0:48e:3767:d885 with SMTP id ffacd0b85a97d-4abb5bcd524mr16582999f8f.53.1795425550512;
        Mon, 23 Nov 2026 01:19:10 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf680fsm23805806f8f.14.2026.11.23.01.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:19:10 -0800 (PST)
Message-ID: <31480f0d-112e-40c0-91fd-8f9c998651f5@linaro.org>
Date: Mon, 23 Nov 2026 09:19:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf vendor events: Fix misspellings in event and
 metric descriptions
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20261120175840.1274637-1-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261120175840.1274637-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/11/2026 17:58, TAKANO Mitsuhiro wrote:
> The PMU event descriptions shipped in the JSON tables under
> tools/perf/pmu-events/arch/ are printed by `perf list` (BriefDescription)
> and `perf list -v` (PublicDescription) as they are written, and the metric
> descriptions in the metrics JSON files are printed by `perf list metric`.
> A number of them carry misspelled words, so the misspellings reach the
> user.  This series fixes the first batch of them, which a spell-check pass
> over the power8, power9 and power10 tables and over the Intel and AMD
> tables turned up.
> 
> The three patches are split by vendor because that is the convention for
> the subject prefix in this tree.  Of the 989 commits that touch
> tools/perf/pmu-events/arch/ as of 65e4fd942f72, `perf vendor events
> intel:` has 391, `amd:` 37, `powerpc:` 8, `arm64:` 83, `s390:` 18 and
> `riscv:` 13.  No commit with a vendor prefix touches another vendor's
> tables.
> 
> The arm64 tables have misspellings of the same kind ("misprediciton" in
> the ampere tables, "executed.This" in the cortex-a55 tables); the s390
> and riscv tables contain none of the words fixed here.  More remain in the
> tables this series swept and in others -- "conjection" and "banwidth" in
> the Intel uncore tables, "pumpfor" in power8, to name a few -- and those
> are left for follow-up patches.
> 
> Each patch touches description strings only, and each was checked by
> regenerating the tables with
> 
>    jevents.py <arch> all tools/perf/pmu-events/arch out.c out-str.c
> 
> and diffing the result against the one generated from the parent commit:
> every event name and event code is unchanged, and the misspellings are
> gone from the generated string table.  out-str.c shrinks or stays the same
> size, because some corrected descriptions become identical to descriptions
> already stored for other models, and the amd fix swaps a word for another
> of the same length:
> 
>    powerpc  13 files, 55 lines changed   out-str.c -393 bytes
>    intel     5 files,  5 lines changed   out-str.c -477 bytes
>    amd       1 file,   1 line changed    out-str.c size unchanged
> 
> 65 PublicDescription values in power8/other.json end in "42"; the trailing
> "42" is not a misspelling, so it is left alone.  The word "ibufffully"
> in that file is left unchanged as well: the BriefDescription of the same
> event ends with "ibuff", so the boundary is clear, but whether a space or
> a full stop belongs after it is not.
> 
> Written with Hermes Agent, an LLM assistant: it found the words and wrote
> these changelogs and this cover note; the author reviewed every change and
> ran the generator as described above.
> 
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> 
> TAKANO Mitsuhiro (3):
>    perf vendor events powerpc: Fix misspellings in the power tables
>    perf vendor events intel: Fix misspellings in the Intel model tables
>    perf vendor events amd: Fix a misspelling in the amdzen3 table
> 
>   .../arch/powerpc/power10/metrics.json         |  8 ++--
>   .../pmu-events/arch/powerpc/power8/cache.json |  2 +-
>   .../arch/powerpc/power8/memory.json           |  2 +-
>   .../arch/powerpc/power8/metrics.json          |  8 ++--
>   .../pmu-events/arch/powerpc/power8/other.json | 38 +++++++++----------
>   .../arch/powerpc/power8/pipeline.json         |  4 +-
>   .../pmu-events/arch/powerpc/power8/pmc.json   |  4 +-
>   .../pmu-events/arch/powerpc/power9/cache.json |  2 +-
>   .../arch/powerpc/power9/frontend.json         |  2 +-
>   .../arch/powerpc/power9/marked.json           |  4 +-
>   .../arch/powerpc/power9/metrics.json          |  6 +--
>   .../pmu-events/arch/powerpc/power9/other.json | 28 +++++++-------
>   .../arch/powerpc/power9/translation.json      |  2 +-
>   .../pmu-events/arch/x86/amdzen3/branch.json   |  2 +-
>   .../arch/x86/nehalemep/pipeline.json          |  2 +-
>   .../arch/x86/nehalemex/pipeline.json          |  2 +-
>   .../arch/x86/sierraforest/srf-metrics.json    |  2 +-
>   .../arch/x86/westmereep-dp/pipeline.json      |  2 +-
>   .../arch/x86/westmereep-sp/pipeline.json      |  2 +-
>   19 files changed, 61 insertions(+), 61 deletions(-)
> 
> 
> base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854

Reviewed-by: James Clark <james.clark@linaro.org>

