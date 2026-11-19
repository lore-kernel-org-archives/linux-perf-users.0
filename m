Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105922;
	b=Ho2K1qTsUNYnmYyBSmGvxp4fNgFMq83m4xxv1JAc6VLWBHp/bYm9pETgyjJuv3aK5y5K
	 WTCkL01x5B0DqxaY0KD03m9WVwD0skyvKm1QTMpl4EiElQ79ceSaZ/OfuqIEaJ3cMwTTD
	 YrwnCa39m12uPiQ4koj8NHWbK9cvywKpLxE/BaBvDouoBhKDYHTC6YA34ZH3CUs+A2A/M
	 ADMSU7DqSvgaiJLtCuvv6cvLmQ2Dj+bduxs9X9O2B8Js+v/keiQ8KRtHgJoXEVsinZyyQ
	 j3F+YZH7WzquChku+J45dIRAlOfawtQdn5r4LRzg+Ogom4+RxO5rMy/WwDDKyQIqI5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j7yMNUPcBawOAAofiPpPFqavO7i9DOB5qyxe4ygPJGY=;
	b=x1xS8fJNGoH57Deyq+kL+jKSEHwpLJEFzr4FfdSG6kwEYE4zHOMJXhC3f1TtjgxF0dy3
	 4JcAQsMbkswpBDViavQlpTC+nvo9IYJsZdkXMDmlF3RCe5hvdKJCsHQZY51Sem0GYYYa1
	 CQnuNbpD4wCyUIbp+6xkN5PGj/MjZkqFvcBs8oWwIOqgRzF0kosrGvbVyxbng1GEi3bH5
	 gu3+/KSOF6WyLZmaUdm9t+ibpuSVcw3d/gJwturGK4brChzp6B1agSFbk1lnQOVw4vy90
	 hTWt0q2ofwC/1vv/jpx0xIYGKG85EeG70iBssQsMeveXAJK4V3y1DP6FJTvJBlcJtLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mFAIxap2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBD606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 16:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBBD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mFAIxap2
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55be673e029so299031cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 08:32:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795105921; cv=none;
        d=google.com; s=arc-20260327;
        b=HA0qe5ujInq/GZpiz2TuCWYWAYUN698sj4V2rwFFPso9F0EOdKz4pDz6/Jo1i8Z7/Z
         cFB33aDqp1lmQaXRfa6kbC5QT3eWRXHewutV8e8y0iR4N76xpP+mC/n9wNxLZKk6ak2Z
         Xh8ssidv3Vfk4giA24uSnKKTfa6WiSdZ6bBh29ORxON+P0+oXfkaBxiWmSGqMYBaMQiY
         UmjNGpr+Nk/BmtU61Vt9vWg6NhlPdjsyn6vE5WBQb4yI9dmbXZzF9OL3ip3nKoIb/CXb
         cT52QO4YmVDtg1RzpRHbFdalUJcwQbiCeiGmenu8ljJAwpcyJVDwN3b9rQaCKC8lbYc4
         EVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j7yMNUPcBawOAAofiPpPFqavO7i9DOB5qyxe4ygPJGY=;
        fh=vrxzrgx2RlG/Zu1VZZa8akV2Jf6impLVru2a6wM9KZQ=;
        b=RZgiabdzNeUcvp/+S7DVbuU+8XShvIGyGK0Ni6cuwHJp7nhMg6/9Zh4sloGjwqxVXz
         Ekt0qEZ4rFkZJ6dVq8JpvMexYyDK801K2Ogs5Ld6oSAGZA+7wwe0lEzACKK2VOP/ph1f
         OSS156IrJOv5TI74a5TiwBiDfxCJL130caLTwFia0aNw4jIID5zySsRlWmPIhTw9wA/6
         +/oQAk/JlNKQgy318zNHo7cO6Q0CsGtBEQHtYfeRYfFh0+FNdiPhdUNvdFagsCnNnt0z
         1QBCstKYTEJv5x2d2zMDNlZdouGrX/HG49wjtM/Isaa4r1blMMg0U1S5mi+1L1Ssn7Jt
         Fwjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795105921; x=1795710721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j7yMNUPcBawOAAofiPpPFqavO7i9DOB5qyxe4ygPJGY=;
        b=mFAIxap2VFR1v9uPD+hQUTepw6PGG/7sXedKMPdVVmdDk0NRJK/HACOYACWO5jpf3w
         gbFn8q+uBItiBZnqUwCO/JKMY/LpjYK60YscKKlECYucnPff6241wnHkziUMygDCozFt
         fdHQnwGajdhh23O3l8m4TiMRuWyjRAgwmJpqg5oVxAaS3zRZafMvKRbBb/yLmtiVQMTu
         xUFur+wS2y8oGWHlFN9YMrgC8UAIlZ3jhF6fA+Z2pw/bB7r/DmbasacWSqv+RCtg5euK
         2aMgYT8y+fscke7rtAMyuWxlO8apNehK0gdbyfwU/LJ6SIOUDOwK5YAePtEhk+4nuGya
         y3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105921; x=1795710721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7yMNUPcBawOAAofiPpPFqavO7i9DOB5qyxe4ygPJGY=;
        b=lFpZaOuhmjJQJP+/GqVkNxe7ClYfhE7t/ZiOGemrKIyCXjHVI66rml2C5PMtvcSdDH
         NSy/ntPf5yeaRzExyGXTYhIt/i6HUAj/5P+2YsLsfi1dt7+txrEf6WENrhZb+Qk7IlXj
         WwssflFBgHDIQDwdUNcgX7zfzGuoooU4uxrry7qD1LW1wuQRcx/zeJXv8LFgLGZc2b9A
         lukPl6p1h4vsbdnSR/xHcoOb32u6dnIKnQUCnU2ImQI8wGofjY/PVfyy1RwwsqZml2yd
         CmlJh5BZ0eWSyMrBe2QbdKVuk8AM2a4+Lbl88jZqUPsvg0Qd1UmC4nla6HdKdREIqHOz
         pVwA==
X-Forwarded-Encrypted: i=1; AL+hErEkUIsvm3GHrA7cp3b259IPZUUnyuwyBdnZgLQ0hJang2mG4AnV71Heb/Jp0tlGcw57u9mzPs9UurKSV+hNFRRj@vger.kernel.org
X-Gm-Message-State: APuU4Z/VNcIO4U/ycjMWJ7K9USYynWsUwORE81XIFl0iq2RH/DIiAZxw
	Y/K+PEttGlgsa+C+IObHLrHv/AknWzy2YivaHBKBLPcRiFeHbulueiEaNR+hAmQDOOAjBnfqYhU
	o8nrFoE4fB0KCMLTOnBWoRScqGba2yjsEG6JQ9lIn
X-Gm-Gg: AYBFou2hZyZSavYRU5clZi7aiQwhNCvo7wW0vjFgmVCC9/cRN+dhahCUgGMjDuEMIXw
	U2tiMIxgPFU9e/vZHUM3XHiVedkd8KP9i2o9zzIbJm4nO5YULSLcFlYfrw2mZaoDkmw0QpfH+WC
	rM6ci6Vb2AVNwemXz0AqgxgMvfVP29RBpyxCX1IXdp2prWkbkQSDfhUGLhPrgFxarFE3Qs8EARd
	tt94Oz0xXtpqtfZot8Tk27Mn8fBaRFpYBOEhK5cwQMdcyyZzgla7ZvaC0os0EdDGibL2AWiABuB
	Gun5XlaOENng8nmWplMn7VyHTRZXruL9EPGCpK+r6pxc1JStYMnUIlN/KLRkA8TRaVQkfXgIbGc
	/9NsYY45usUk7XpJ5pEBW12oFnB0Zc0ZFWwOjYg==
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr16593651cf.2.1795105919993; Thu, 19 Nov 2026
 08:31:59 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117185305.108003-1-irogers@google.com> <av6mfhEBYhJUebPZ@google.com>
In-Reply-To: <av6mfhEBYhJUebPZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Nov 2026 08:31:48 -0800
X-Gm-Features: Aa3M54ry8V8L6QnN8lpgrTFnO3sd8eftianRLEL_N05ktRrKLRjNBKFclMwv6Ik
Message-ID: <CAP-5=fXy3L42T03AiSfhmw9pXR5-VTxFK4bKu005tkocJAXp6g@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] perf symbol: Sorted arrays, DSO-owned lifetimes,
 and memory shrinking
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alireza Haghdoost <haghdoost@uber.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 11:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Nov 17, 2026 at 10:52:56AM -0800, Ian Rogers wrote:
> > When profiling large binaries or long-running workloads with many DSOs =
and
> > threads, symbol and DSO tables frequently dominate perf's memory footpr=
int
> > and startup latency. Currently `struct symbol` has several structural
> > limitations:
> >
> > 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
> >    `dso->symbols` address rbtree, plus an optional negative-offset
> >    allocation prefix (`symbol_conf.priv_size`) for `struct annotation`
> >    state even when only a tiny fraction of symbols are ever annotated.
> > 2. `dso__symbols()` has no internal synchronization against concurrent
> >    readers/writers, and `struct call_path` (plus Python callchain frame=
s
> >    and nodes) still retains raw `struct symbol *` pointers without
> >    retaining a reference on the owning `struct dso`, preventing
> >    unreferenced DSOs and their symbol tables from being safely reclaime=
d
> >    under memory pressure.
> > 3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
> >    invokes `libelf` section/program header lookups per symbol, calls
> >    `elf_sym__name()` before filtering out non-function/non-allocated
> >    symbols, and resorts `dso->symbols` with `qsort()` even when ELF sym=
bol
> >    tables are already largely ordered in ascending address runs.
>
> [...]
>
> Applied the first 3 patches to perf-tools-next, thanks!

Thanks Namhyung! Should I rebase or do anything else for the next 6 patches=
?

Thanks,
Ian

> Best regards
> Namhyung
>
