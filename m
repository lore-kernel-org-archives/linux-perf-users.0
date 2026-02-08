Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA4338599
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563789; cv=pass; b=aJcuRmtbtENNLaNNYHMWtpYwgkZtqDHVCaPXz10ONVRS26v+VmUgapmr91szyhu++SDXnfz6VCv5caajSNiULaX4oMZ0AaAOHmg111/wAzQtFtgU52vFZ81gBFJV8C6l3xUX6hBPB6Bb9jKMXO/6dtNe3wN9p93OnZCkOwUrtqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563789; c=relaxed/simple;
	bh=jmAyjtACiSCPQEAmRMGTICjJnLwemPxRTh95jqaPKu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ16gYv5w00nyrJfddPM09P0K51Z3jSU++w8PDS+e4Ee61McOuaPWK1W7xWsJJhymcdQwn17jtxqY9vkn6fUyz48UpWtIdniZ8/1lYHoLV5AqpcDf/O2z3xoiXeXZKCZtrtqRQ1BIePegHA3lCg6YibTbnVk+YBV7yCIrSTFrWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKjiXxPR; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKjiXxPR"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba716126f5so9680eec.3
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 07:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770563788; cv=none;
        d=google.com; s=arc-20240605;
        b=eis3KnahlydZQruDGU73EDeT5KEib34NwdV+YT8FT06V3bqGlFmy9hpvwQdACTdsnv
         ChT4ghl7Sfmz3C6nEnE9k4vyIZHXDGcf0HO+0vW0MSVgSrneJW7MyS1VkLNHTQtY/7Nr
         kRWS4bsqvsnMiCsAuTKvBIX/JMH5jOM3J+soAw+KI7S+J+yrcrAWgE0T7jVgZ9WB6Vat
         +e2dLMMekxhHE8rarrrDXcgWKhhlZVZgvYNsGxH9GbfooyxD95YbHn904NSOKkO1TSLW
         rkR3hRrAboFME/YQE18/0pvUQqXUhv4SEorDhEPAUuySqrMfTvH4FdzCjA9JV93NTZhL
         /eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jmAyjtACiSCPQEAmRMGTICjJnLwemPxRTh95jqaPKu0=;
        fh=2R3oCIwsfQfGOXYWrJ2MRGxUYwPXRlrV94UEQfHq5DM=;
        b=O4mnKWdvYnWyz9LtCW+8WUXjv8fZ15bDlvHwwnF8+P96kORlnR8zcSG0n9J4jVL8wT
         ksv6C5PC14yqBJWPkI3eOJlbzmZ1doNx+McYa7Fhn2Pcm0qUwjpSuIRpixGFBVCSs/kJ
         Lwfh95Nw4Azjd1EboIS+G6MWHzD+MxWq8dEqWggoFe+u0qpLa96lFEcn94cOQsdJ50fx
         BrvKE1HlHR83wrwF8+7vxj7lKjGyPg/z5KgRckb1V0kisGXcLOg513l2hpq0q2phviZM
         gPLZ/7Xw3K+nT+icxds3jA/KjdNoTX3bgnAgfCfa0w3+R5kI3iVCe4Tyyj5DSDl2dprf
         mZxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770563788; x=1771168588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmAyjtACiSCPQEAmRMGTICjJnLwemPxRTh95jqaPKu0=;
        b=ZKjiXxPRTK7Qry+k5EASRJJSmlK93UmmO8UDsskqVCda/mHV4XYzDWyAHuaqI7+MZA
         rByAGCMeezqZPq8tddPVUQ/s4WumE3/wGkd4o8U2bLBMhla4qdaYP3NeYaipkbsbIH6h
         6qLFC9z+rFZAMBXWgV7Wkq8jBO1RimRPh3w8slBBvVjZZHJZjlzUW0v1dXbwWJD3SJkw
         xLOn1zfjm1lc0hYemZFH5cydTFOu4I1B5psNGanWD2RrZzEocSatvgFKxR1IPGU+CMML
         Lys3Rl3oi/V3FnnTc4rqUifSwQfgogog+rwlwV+4aiRDXRS2BC/MVlWPu88oOFXU+rYK
         AXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770563788; x=1771168588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmAyjtACiSCPQEAmRMGTICjJnLwemPxRTh95jqaPKu0=;
        b=bndYV3tSlmMz9Y7Oh5jv/KefymDoXc1slEhap7Fy0IJY6khhxCQrhmdyY2zcVBFFvo
         hFt3bFQiU99UnXnjVUshHpQ6RzrUeG/y8OT60dv43TzcB1QHI41FJNI52ZnrWjE4FN9s
         eDb5DWRcdokuliY7m4J29x0h3xTvlOJoTEN+TIzMyeSVRPVfCjH7NyWsZ9lzDOt5aup8
         3EQOQgOeDdCCynS2kt3s5CYH1i40CSouqDmFFKSGY21kms8nuy6cnXWG+SoroTvRSkeW
         +lFdSR3sbkP/wWJ4uzTPiOP4NLKeagVIvqAcghGKB5o7gj2vWTK/1OwDiBNCsg458G/4
         cspg==
X-Forwarded-Encrypted: i=1; AJvYcCV3xEfKptxC1ttQekp7JOHZfmeKGq/npOrECi2ziDrTX0H2t0qn8DXuRcQEV2VXRNBF+87OGUK0GsAfJYkkRVTU@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsse1+/tUL1pChdnYWw5FSQbD2WMrX5lRwEOmoPlD1FSfrQeE
	EUTWTO2lyqHvP8Li9j7uRnhtixWVxB+YISkugKORurNiUmR1NdCaaf7pLCJhFi0ics9G1bzUgL+
	HOzHK2gL4luznEaIJHkyMPEh4L6KUg7k=
X-Gm-Gg: AZuq6aJQ9GDNdFjO6ohxR5a0rTDrvfLmpl9f/UT9UzXT6R9jfJ9qcoTFFXjzMSPJ+6V
	ZZWhDoGSErbJX2NmcXSF0nhvxAOB90CkoIew7Vj4dhAxkc17gUKgmAqV2RynHWiOf7j7JVBZ14t
	NZpgBMK9KMfuPJainYfJKRjZiVkUPRA16asYnrlteB+chmfd7Gjuh4Z2pOQFpTSNh6XWcEGkm94
	lEsaYXscmM7RYrBb+0FSdwQjqZjA/2+Z6SLuBy97Oni6e3ihC0+vRE6Yo+iSdZIGOc2zQN5MM51
	JQVLRoXkoycIiHRvZ+N5/PJkeocb6K8w7mHkPrg5ZwIrpUJ/4Waymx4KH9aRuXAPZjtgdGZkEXE
	yYxhsilpuAMDu
X-Received: by 2002:a05:7300:dc08:b0:2b7:b6ee:b3c6 with SMTP id
 5a478bee46e88-2b856520cbbmr2075162eec.7.1770563787994; Sun, 08 Feb 2026
 07:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208122227.3524-1-9erthalion6@gmail.com> <aYigHLZtXooznMB7@x1>
 <aYig1O0-5yxy91la@x1>
In-Reply-To: <aYig1O0-5yxy91la@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Feb 2026 16:16:15 +0100
X-Gm-Features: AZwV_Qiu4OKbW4xqVSy-rfd4vUd-D73QLQerjhiUTXcbQxRD6AzuaUXsgSc3LgQ
Message-ID: <CANiq72=URHDPz5=t5jDr1r7whEhRzQiJdMMp+HLyP6fBH2xfZg@mail.gmail.com>
Subject: Re: Rust data-type profiling working in perf was: Re: [RFC PATCH v2
 0/4] Test annotate with data type profiling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 3:42=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> This is an interesting piece of news, so CCing to lkml and Miguel as
> well, please CC that list in the future.
>
> Also please consider adding examples of output of such new features, so
> that people can quickly see it in action, data-type profiling for Rust
> seems interesting, right? :-)

Thanks Arnaldo for the ping!

Cc'ing rust-for-linux as well.

Thread at https://lore.kernel.org/all/20260208122227.3524-1-9erthalion6@gma=
il.com/

Cheers,
Miguel
