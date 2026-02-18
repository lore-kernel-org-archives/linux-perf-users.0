Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29E30BF55
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397291; cv=pass; b=Pc/PBtT4iKcDuZxB9cwKqJkdlD7UTqYixmPtcRc/uVNle5+TxhsPKjGn93ysVOlOO8jVi6CliNDxLADMsSdKI+0s2DBDltCFnXmxewbmLbyDR3dbwokFC6UIxXxgLuInZsnetbnk4kCSZrf+H/kVQ1iVBghhLNlRKwFWsmk1Uf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397291; c=relaxed/simple;
	bh=5vm0AXnF/UK883/jagsuZ2RwgKSkop66CW4ybleFQu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy2BgBxUmkw1VMoD/cI4XM6VFPaeZfgFfoHzxX8x6dykZE4NOGzmGqEJa1zKEQhkZwTjsPEjqEF/nCkjTODIM8MAO0rOl2/chup+hzyJy5AFtLEJEI/O8P9ksfo5s/fkcAdhT773/REqWN0Igw07JSnuObCuW/yRpvssMasrwYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfD7gsny; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfD7gsny"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-66f3e7d9eccso2784634eaf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 22:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771397289; cv=none;
        d=google.com; s=arc-20240605;
        b=kJpB+WPqMYbNW46/xjtYzdrS/3Uk7XUovhoU96gnrdMvZ3fimC/GdFDlq5lHnjE9EP
         pdLgMjF17fe9TxeUWIH0X+nXIXPuJX7SHFv3z/RsYRb898Md+WWMhBJMY1t4vwJ8LGN0
         /bW5X9cGujPi+4BUqxFbIu0Oy3+bsodMcdlsa54igAYg8GrVVWYcRANJWh6bKEBeNp+3
         F/xu1QBRnHFytNbeAmVe8exT+046YFmRCRwK6piLpAiGnQfYI36xmhdai7gLiVZmEovT
         JkZFiLlJfmJ8DqhXldro20CtjVJ2tfjoT/9x3c5tg5tIaiq/sESNVNpjI5Vv1AiAiUzy
         842A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5vm0AXnF/UK883/jagsuZ2RwgKSkop66CW4ybleFQu0=;
        fh=7hRrwH34TuvFU4SGpzg4hF0HkmTB+ryfhLksu4haWOk=;
        b=hDMu0F2IuUWgt7rJqVVw/ihjqsBsxrUZ/wUa/p3LH4D/gnoV6txUgV3k5QXF5zzA+R
         PBi/6S0obyDCS4vxEjGsWOSSGEB1jpDbjwb35L8jwFilNiNqjd//P9WMYpNwtPW3sbHI
         k68YDqYeqmf4eVlp6CkLiBJx2PMZv8/Ck2eDjqAOS9QFyh6GutlkGRRN6b3rZywqHbp/
         JnmN1LLbgOf+72LNhXX6lul8rryapuxLvw2x4jyj9w/0wOL3G9sMy+OJ4UkRSMh12ErN
         Ye9MYE3oFWdc4d56uois91YunPU092mPZmGF+IviVJPvWx3K0lQpGMuvT9+CWNdsVwJL
         mF5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771397289; x=1772002089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vm0AXnF/UK883/jagsuZ2RwgKSkop66CW4ybleFQu0=;
        b=RfD7gsnyIO2P//GILaFuK4VhEnVs+Bu1amBgMxjd70S300HCmeL7GtMfjLEtb1nZd1
         AkOr8wK+AT+JZAYTgHwwkKZGGsAnRSAHZRh3qopfCH5F6cmQ1ZEBcrlHfEy82kqjer2t
         ar48O/+AHAsd2cbQ5C6qGmrTnhm5FcNNFeJbN5pNNeq8Yaj1u54m92q9Hix3DAzkahYi
         kuaRuqMeTYb116bQyOv5LoPvnUEeFXetJCNGNun5J15kMv81xvlwinslDoesWYrJdPk6
         MD94g/bo01MiThwUSrEnGVJ7ph3TGICwXjeBZ+Jc1PgKfoIhEWR3oLyZYLIZCun3/IYf
         4AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771397289; x=1772002089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vm0AXnF/UK883/jagsuZ2RwgKSkop66CW4ybleFQu0=;
        b=pFfX/6jgf9hop8Ua+rRgSYPhaQe5XNS4szIDDiK3Tv2dPIn7+qxFXl77KPlADHFzuH
         UNplzjqA2BpK6R3HfdzZfHyqONxML/6/OsG88hmq4dFBWiYNJ4zu5K2v2QYnbmP7oIjk
         AZTWpRZZWfFD273joEKhZTqVIWKGzqEpiAaOI31LOPsn+6mI19o1rVBS6mhQY3uJQrHr
         zor1nVICDwTPUdXeGdXGe4fHSN/JGs2NdAtQX9/oPlZw8p79ImxBLdKwT/B2TVE24KhI
         mlwy4/6N+z4AqdFgv9XW5zvnaTJMwC8Pt1lSAYOZQyd0i3qhSRw8Z5ZEqDGj2a2qPUKq
         iGEA==
X-Forwarded-Encrypted: i=1; AJvYcCVLeepguBJx/JJ9+pm9Ppb9pyY2bmtu7E/kkLZVxBnuiVFjqKMyiRbpow0Rjc2rBswcvTzeGyephxQUNY9IfkaV@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmU99mGU7SzRhgGj2SPC5GyivYiKVonLbbGzdhuK6Vj27gm5F
	utEiZbZ4lZGTRu2fwUCzDhoYY+7Gsg270mwXaWRFDc8nf26A0776ZqPSgq2BjTq5BiZikBXPVE/
	vaBiUtkw6oIzsnS7U/s1I26d55EmwyJecHA==
X-Gm-Gg: AZuq6aLmLTk6tANf7n7N7XVBrq8k1MShI52lTkjcuU/3wCgu/L9dsBi54c4ztvsdtz8
	JiuyjJnibbY6v7yvi5VbK7qua/5wPOQgs9h8LrBNRSsQT95bEfL8q2JHvi20lpJNdoZmKR9GLmx
	tmthS2PfnXILJnIHmM73kCHlo+3zGflBhpYau11W2HWJFwHPJxJhlKR4wWeOPNF/Xma4BHIJIeX
	QlRTEJgU5vxYteAP8HTPZ5BG8KQmWUbrUO93RXWhszGV56BYY8WINdfjKtogGVg4LV0FJbroFZ+
	UuvKBws2Nz97h904HKB4DLq9jAN1PT2ECdFj2hIpStpRn691Z3iqNhs=
X-Received: by 2002:a4a:ee1a:0:b0:679:8bc9:5ab6 with SMTP id
 006d021491bc7-679a742d0b5mr547565eaf.43.1771397289052; Tue, 17 Feb 2026
 22:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYHVnXddP=V-q=0Z3Na1FOBaQRT3RA55ruDY=O0pNpbaSc4jg@mail.gmail.com>
 <aYo334TnekI8UgpY@x1> <CAFYHVnV8h-ZcckoYKER127U5cYvvsye0iXfgQ2aA0ddr_ivrTA@mail.gmail.com>
 <aZUec9wQyPawz4cW@google.com>
In-Reply-To: <aZUec9wQyPawz4cW@google.com>
From: Noel Grandin <noelgrandin@gmail.com>
Date: Wed, 18 Feb 2026 08:47:33 +0200
X-Gm-Features: AaiRm5372JgRrbo2nhynzi4JyoXVmp7pVj9O6-H_2XSFwBtfH9z4emhYSXBEeJE
Message-ID: <CAFYHVnUuc5oHZ+vQ=sKOW3JRdKOmwPKTPmhyUzJkQxk_y5Jk=w@mail.gmail.com>
Subject: Re: why is 'perf record --call-graph' using addr2line?
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Feb 2026 at 04:05, Namhyung Kim <namhyung@kernel.org> wrote:
>
> In the meantime, I think you can disable the build-ID entirely with -B
> option.
>


Aha! Thank you all very much, that indeed fixes my problem.
