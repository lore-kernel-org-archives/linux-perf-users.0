Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A063AAF56
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841302; cv=pass; b=U4ddmd9v5QADaazxonHf9Iu9NVTQamR+rWcg5IN6J20QULv9MezLMXmOyBk+bbGVBO4i9C+LtAbj9GdqFmTtzHnTBUug9GhcUyk8Wg1i4emTOU04VPOGVVkeNNS1qVIg7dr4ziZCDugWnztBN9LNU9TEi8Snl4xgBSIurvfpYa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841302; c=relaxed/simple;
	bh=UjiMOoGqKl1AFGTKXUXfK6wWEi45TqjVJvcBDz0JCew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W28mIdHiZXCimM7mJ8iSqG0q4Y16bipj86HPB660RV+jPjVUEgDFHoYRUOnAilJkpkSjuT6TcO5V5x3zsGv25YInd+Ko7M6qJGhVcvnM81jmE/lfM0aHc9rn+KEO0TSl0WIw2gDTrUNfwytKf8APVHo3mbYWvosVm56TTnSLhrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebogoDtX; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebogoDtX"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53584e7c349so559671cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841300; cv=none;
        d=google.com; s=arc-20260327;
        b=CFsF/uKHMHw7OdMDmLSNFp2BKHdckRVazHoJg8KcEO9GZlAz58Gx9q3lf+D1heyUh5
         sMqzru2ZplV4TGTh4UPOFtiuOpPIfMTNnqURFPLfA4eCVJ7KokWZvqDi7yoVctJusfr3
         ifi9vDmFjGEGEuE59hogJtJMw+R4R5WN0Ky651X+57Zxk7XfJ9RGEkgWOgXeuetkb0/m
         pvBVbUR0fHlPNwcLCcZz/KXVGLrfOjl3N7MYXCSOB6i1IR/h3tOSu8IdlAVjUK/Fg0Gj
         ZIkCRNwZh3tqfHnKvYsAVX8NONfXIvNYSQDeUbaWOAPt7dTvAeZ/FzlRoDlCJ/nJ0NB6
         ZhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ujfOyylHH0+Qcr6VmePM6uJ1Ba5lYDsIUszcZYvjorY=;
        fh=jp4BuBAJ28AWHdtfVtCTu8SdBohRLvQ2iNjJKpspToY=;
        b=Ursv27RiEWQ7eCg/DCuRUctNBttnFv5xMx77MDiL48JEXL4Ovs78yltayX5n04fVhp
         /Ni0i8XWNCoqOTlc4h9F85ofxmO8R8oVyp597RXVHs3HVoqxhHjLnCQsMld+B5MjZRlJ
         Yu2AW1r4aoQYYuHtCADKH5mHLBRoiJM3FY9rlLYULG6SIk0dJs8Zx6I6yYFl2nmz+pLW
         JaQf0XnxHxAwulMvOvwoFQ99KI/pe0hdQc6wDB4qlAi0VHgDKIjXWKr4KmwtxMMiswGq
         tJ99D2p6YPye/EgUw8H3pP4mCaA3VaKyIDuUj0exkoRn9I6QP0BBRhh5Q+3c5dSBJZLp
         FmIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791841300; x=1792446100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ujfOyylHH0+Qcr6VmePM6uJ1Ba5lYDsIUszcZYvjorY=;
        b=ebogoDtXueGu03DiiTO/MvfzhNYgIEnoPnsGcSSxH5uamob88pA6mKu3djve5VRdbJ
         abM8DWkAwT2Qlp6CDWGh3wTIK47ywaq3DR2G7ZPqk0810UXmIo4ISrnNComp/KojFQ/6
         oo6HOgwo/yp2ePaFqsSH1wQrxCBKbPM7IS9icqPlnujRDPq9sN/FRyYPix3z+UHPQKzC
         BPWfNtZFzuc54mpfao7l6gd5gMLOlXHi2o17Pb9lUAsBhxG9zMZFDaKpZonkQuGlbjKf
         XIlEiM2pWsISBAHskKdnEFKj0OpP9Wd8MKdz5Co6NdFBUIaRroFN/83JEBeR3adKHy20
         KZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841300; x=1792446100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujfOyylHH0+Qcr6VmePM6uJ1Ba5lYDsIUszcZYvjorY=;
        b=QTwLpc+gtiN7ehWW6ZCugMTcdB/ECHENN8YlN578QY01Q+aRd1ndLwdGv22D7679GE
         smungiTt3ALDNpQIsr9sjKazimwWBLC3tWvB3adlc8TaXg2dcPrflwsvDITaoONDSfA1
         oTWi6LmN+TkHLe92FrX2S839UqP/wi990PhYENHYjQPP9/SZntWWjj7D4joNW4Z45T/9
         ZsVSHSYZba+2yGmamcDQbT3g7TF5946qF9zIAQeXoYLXmBE5EET6BVz7dcJPqUPv9ik/
         YJbf/Wxhz7Sk0IrSNGMqbdyzzzyEybB0hqLPbKxEf69Vz8Kn0yq5C+GRtR0CtZpgn+a8
         VC2w==
X-Forwarded-Encrypted: i=1; AKwUvBx3QT5gTcWnw1nFlXNTdxMlAAy15MlmFtPZY8S5zaPUtll88F7HkzJeTDBcKEmlAsF9h/AZUdS8clnk/DTX9MA2@vger.kernel.org
X-Gm-Message-State: AFq9FYKUJuevKUAB2bqmMzTZlRid83XjftCKAFwJVrRW80wTO1Zw1tET
	YYNwGG/sVffaH4yFi7GdIH5Ly1DwNdXBdzujQ7tE7L9BPJtx83jYEgYfOhwDLdWe43nVzUGgS3v
	SCbS5lHu1G+RYq6Vi1t0KKRxkzrYuB8YNi4rzHgsv
X-Gm-Gg: AYBFou0eWA3oH5I4htoqtqXlcDx4fD1rWUQmxNuIb8L0H5wLa5SWte0Kif8ReH9jiXf
	q6SPKGO2rm/YNAjgcXMGOyse9fK2d/FpnK1WCUFwGaDZoY/RyGreOpNvvMrWa6HLQqoprOTGcbJ
	ZNoG5jaWGwPisvvPmNHlcZUPjPNGcS4DsJE00PNoMCjqvOPyxPzg6QbzmNAFRsdR81c0tvEeKro
	dIfv7koYxwSscp/oNW81Rlsneld4/q0WL+7P0ABzW3vbf485zxnjsiFMJuSkXF8IQiwG/EBQRFZ
	xz0nnDlg9Mt3tsO+CxVw8EuiL7doR4KHv/BKzG56giJfPalvIViuBnONfqaQuXXGxBrw2wVWGkg
	WOpKRJSeN9w==
X-Received: by 2002:a05:622a:2b05:b0:531:16a:5a3d with SMTP id
 d75a77b69052e-535b4f41d7amr34879941cf.12.1791841299643; Mon, 12 Oct 2026
 14:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012052601.13920-1-namhyung@kernel.org>
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:41:27 -0700
X-Gm-Features: AclHuK_xa6jARGF19pV0rzh8vArCUJVzxFb883MZyiwMHhKkagyeLFaZzXoCBXs
Message-ID: <CAP-5=fXg3LYS0ftt1WjDXgEh6DLjZcYQiVNv=ym7CAA9PyiQ1A@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] perf symbol: Properly set DSO binary/symtab types
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 10:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> Currently we have 3 types for a DSO.
>
> * binary type: determines where to read binary instruction or data of the
>   DSO.  Basically used by annotate.  Some (special) DSOs like kallsyms or
>   JIT may not have the data though.
>
> * symtab type: determines where to read symbol tables.  Set when symbols
>   in the DSO are loaded.
>
> * debug info type: determines where to read debug info.  Used by srcline,
>   DWARF unwinding, data type profiling and so on.  Often debug info is
>   saved in a separate file.
>
> Some DSOs may have the same type for 3 and others can have all different.
> Previously it generally assumed binary type would be same as symtab type
> but now I think we should not and only set the binary type as it's used.
>
> Also it should make sure that symtab type is set properly after loading
> symbols in the DSO.
>
> Probably this patchset won't make any practical difference in runtime
> behaviors but I think it's good to track them accurately.

Except for nits and resolving the remaining Sashiko feedback on patch 6.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> v3 changes)
>
>  * set KALLSYM type for split kallsyms DSOs
>  * take dso lock in dso__find_binary_type()
>  * handle EMFILE failures in dso__find_binary_type()
>  * drop the libbfd change as it need a separate patchset
>  * lookup binary type in dso__e_machine_endian()
>  * get rid of machine_or_dso_e_machine() due to a lock problem
>  * fixed a bug symbol__disassemble() for BPF and kcore
>
> v2: https://lore.kernel.org/r/20261006234315.920817-1-namhyung@kernel.org
>
>  * add dso__find_binary_type() for checking ".text" section
>  * make perf annotate use the dso's binary type directly
>
> v1: https://lore.kernel.org/r/20261005063411.114244-1-namhyung@kernel.org
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (10):
>   perf tools: Remove redundant dso data init
>   perf tools: Try linked debug files for DSO debug info
>   perf symbol: Update symtab type of vmlinux from build-id cache
>   perf symbol: Set binary/symtab type for split kallsyms
>   perf symbol: Get rid of machine_or_dso_e_machine()
>   perf tools: Factor out dso__find_binary_type()
>   perf symbol: Set binary type for JIT map DSOs
>   perf symbol: Do not set binary type from symtab type
>   perf annotate: Simplify symbol__disassemble() with dso binary_type
>   perf test: Fix dso data tests
>
>  tools/perf/tests/dso-data.c |   7 ++
>  tools/perf/util/disasm.c    | 124 +++++++-------------------------
>  tools/perf/util/dso.c       | 138 ++++++++++++++++++++++++++++++++----
>  tools/perf/util/dso.h       |  13 ++++
>  tools/perf/util/symbol.c    |  50 ++++---------
>  5 files changed, 182 insertions(+), 150 deletions(-)
>
> --
> 2.55.0
>
