Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303198;
	b=hUqAhK2QgQrxi0j/vtOwRms4D3IavAPg25V2XzS+7ErCQnhKLXlBDZQgbxl+XLyQBth+
	 Rpx1yaRqYV9dGCLXIr+OLlz/Pnx39bZRYrKdOd9Ku5oHQ/0YrJURs1tdTyZDySp1kNy+M
	 B5S2TMK2kOMAavd2AdDmZB3AsEyUsDFA8CZGAr80e8PLAwjCCdhCFCiLj3GgpRiBxbHGN
	 lZGtwnPdaaamqV7gbTXfsICmudsI+J0Zub3EvA9nonPSmxj9sNs0JMYWzIbU3rWYznN4W
	 LyZuNi4UyHQS1ar+jJ74IUxJUdcgP/DrNpxysh4E0IfenjsUmsfA/6B4vaOq7Gzjrzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RosLk8H/Wtqi+HeZmA1Dvq0kWL+1/+UBruPWo3aRSCU=;
	b=L8LjkrF1f85/nLMUykWAlK8lxAotfb7U8v1XzYggWw9zYV/pMdhs7ahAPwFA88zZk6Jd
	 dSeYofGPKaGe1WQAjlq1Qi/n+Jq3sfQkQAtNUq4WVBKkjQBjzwZmBFFZ0esP3Nt/oMYwJ
	 dK0aeNNoReozpLjRE3Cgmu1nGQZB3GO/OLJ3oKyglUdsZskC9088Ct+4u7+U2k7v3lOGR
	 UFBJIFSDfg4NXhnmctP00AjWhaLHBw/r+pfMHdsXRMg0KqHQFOUBXk1tMaW4kWn1z2kvQ
	 FvP69l9OPQI/EnBoAsjjrGu38KsKKKTiJ1T/7R77bcUJH/DBfs8B/pIZ86c6Jyl+ang==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b="YZNj/OEX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2A606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 19:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BB2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=YZNj/OEX
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6768403e9bbso2570093d50.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793303197; cv=none;
        d=google.com; s=arc-20260327;
        b=dIE//bMeEG+grBPe6fcvlFmyK26LNW4OuqqBCNIS/TdaHWRy71wvXj43FTb/Co1+Lj
         X4qCiPQPrtw9Rs/3tW3ytLvLcN1e7L/FlocZCRw44HVl3VmuCMURh8WUwgiiv9lzwPAB
         N3BgGFRgGPb8e+iYs0ygZDDNFAGefXqff8wuFpIOxktAcK4+ScBycBArlgZufsItYidK
         TLpK5D+0gQ4XaGGX6I5qMxJtK8S0tqmch4v8xt7OxALtsuSVvPAgnFICwoHWWEQS7Nce
         4HOIoPcT+Ln3LFc3fv17zHlawgoPfvA/0Gmgare/CJhly7Bh+n4b1PNc4aBDirVzABf8
         Jr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RosLk8H/Wtqi+HeZmA1Dvq0kWL+1/+UBruPWo3aRSCU=;
        fh=hfi84HKfd2Ddnoop4SR++lEw2ePuNFDQbrNJZVUGcTY=;
        b=ePT+3pia0uWX9b/DKT2Kv9OZ8G4mvBbv13GQOEYyNx8SuFkMMkpzA5ZiVHpVv1uLHp
         spUjSJxv6Q0Yso0+aMoqwZrTaFhQ5G5GeBmWGz6hSY0bYkoqw0QRvGAHICRs6MKqaVvj
         mk0XypMy6NaobAi08rqs9XCtRkxmukdnj777qiD0POK0APch3w79rR3jxZJqP0roiK8H
         zdFSRGBreaV8HoUpG4Ffxdx7z7qV1zrrKuBVXHxdUXrmN9YZ+745O3ft5Po3yB732afk
         id/+Nkl880jedSVXfLHkjbvJ28809p2SkpaVSCGbQNIRIHn+sALK9F/YJYd9ApbKYN27
         963Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793303197; x=1793907997; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RosLk8H/Wtqi+HeZmA1Dvq0kWL+1/+UBruPWo3aRSCU=;
        b=YZNj/OEXZfjq7PfgL+5wY8xwgvKi7jgxmQgHl0hs9TcKoZpG5LLaCX2A6nAi00AzXB
         1lVQp+MOfljIv1TPvMIfiMqm3WLp8PeDWRMzHIxJkLb7PNMnme2MMh6o6GaZrEsOR1Nb
         +lyPKwjjjCtxEKcdGVIhjBMhKwfMOLhROv35o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793303197; x=1793907997;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RosLk8H/Wtqi+HeZmA1Dvq0kWL+1/+UBruPWo3aRSCU=;
        b=R/eGmZXzYeRVOETfJu75LYDukTOVGJis3n2vdV60Vb1coyWYR/reYggPGVNN2H5cxW
         ithwpzb2Qwd2zlOwaAEoui88mmK56D+ZtmaleWuUpe1WsT/hWdJSOKv/CRUpulWrvqU0
         l9r9JbG3QW3HDjTuN4Yu/cE/asoSSgqKF/bYrqpuIB0G6rvRPzbu1XPqALta4izHmuOz
         CVwcp+IdZJKZX/AqaHCLUrbyR/kuH/NnGnnMRfTymH5QcQDb38jAb1FKi2lDC1az9AFK
         M0rVM+ce5YD/MC9D0k5ca06tatatoFuH311fk+eUGIICQCUh+5aLiErLbBtsflxQ2RrL
         9JZg==
X-Forwarded-Encrypted: i=1; AKwUvBxQ5xLHyaan1RsQOF8yd3A5JiDTcpW9Gz+jDNWAT9nnRqvY3WyOvM+ap/VfgXR/a/vMoLAREk7pYGIwrCYr8YiH@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5kuD7NpxCKx5fMqQtn2Vf0RfQ3PcgmjJeC1/fInIZFPItuG/v
	qOY1z1V9TkpyyplVsLRditxmjSladbwopm5RjBZnq2nVDyn9RhgTLs+VClqgSdyUprSKIBydnwi
	9Di7TcvYM012dt8zlQO4wRn1VeF4D5x8i4Uo8fYNf1g==
X-Gm-Gg: AYBFou1+v+3nnOTl1R3yZLc5XkFkBob3pQJNiAwWvLVE1TT/swO31SyNaSt4FcGryOh
	Vjy6uibGmpMcjizaPLjS4J92OLdM5yl6R0BH1eDajhLXObJfialXSSNQfjx9QQqfA3TOLWN6mz1
	darRfVA4W/JKukAkHHym8+EKXiuZdMHzMR+anQaIJpkYvuzd31BX+KBjoV6h6TyBC3aTejRx6/T
	IItk+Y0aXmAhRYop2XMcETtGq63acBdlHT867DzWs5M2EEJRdNIDZsRTLsH+kPLtC2Ap0Xv6dld
	CUZNbenmd+7lvU/9hBz/Y2xmvtoJeMgIfBUZci8byi+cbsxYeFtKwOTC4Ei3DjTQ3RPuNqVNrvf
	V+evFKZrAZ+jFzWT1mUltg7ljm/H8Px1ok2I09vigofbDN0jI76360COgY8RlGMQoGvgIiw==
X-Received: by 2002:a05:690e:400f:b0:679:98af:494d with SMTP id
 956f58d0204a3-67ba5030e1bmr110412d50.84.1793303197162; Thu, 29 Oct 2026
 12:46:37 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-2-irogers@google.com>
In-Reply-To: <20261027231513.816148-2-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Thu, 29 Oct 2026 12:46:21 -0700
X-Gm-Features: AclHuK_6NIIUx9h5hPScQIIEWDk-5P3kziaP-6o6H7veLJVOSuF2GiQo2oAQCQw
Message-ID: <CA+w=M=SWCd5zBURRERBsxA5xTDS6GoXXgL6rzSQFCfvxGC=HDg@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] perf bench internals: Add symbols and maps benchmarks
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:14 PM Ian Rogers <irogers@google.com> wrote:
> +#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
> + struct stats mem_stats;
> +#endif

Does this build on a libc without __GLIBC_PREREQ, such as musl ?
How about nesting it:

#if defined(__GLIBC__)
#if __GLIBC_PREREQ(2, 33)
#define HAVE_MALLINFO2
#endif
#endif

and then #ifdef HAVE_MALLINFO2 at the five uses.

Two smaller things: 'perf bench internals symbols' exits with an error
when the binary has no defined symbols (a stripped executable), even
though the synthetic insert and lookup phases don't need the binary.
And symbol__init() has no matching symbol__exit().
