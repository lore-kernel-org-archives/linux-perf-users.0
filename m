Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484E1D5CC3
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390778; cv=none; b=WXNgWU32+11FZZZ+8b6Okn4xL6hJj2zqEWlMFOybw58aPy8ayDUEpLwAkOCA4FLOtO5GtNSJ2A9IhqsOjYVBGMeG5whqNGsvFEVbQTfAT55a6L1VDmBbReVbqwDgpBse2f3gnZ0k2PP0uyA4Te5fP18nNlhB7gNk0DfW/CNpmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390778; c=relaxed/simple;
	bh=CvaDCnV+QaG24AvL/P+QY+StDOYTi5CE3AZLUYyMlzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv4iDDGAQJu9nMjMmfx6wX68vT8/FeDY75vPkmChnmWCbtpHid/JYLenYdkvDboQxT/Earc4r+1fSd0BsLq5C2/lyLiV5i/aFhX1eJv9Nl5jfgGI52aqliUrEjtbb0b8yRZop4n628g9/ZDN6Agkasmwgqb7csF4OqPvL77neio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bzCvo/11; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bzCvo/11"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f51b67e16dso66264041fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725390774; x=1725995574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRYQuA2IuhmwnyrQ8YBT5Ts6fvjQ9S9+/c3CTINRklQ=;
        b=bzCvo/11sPhzkNrfDu/Hkg34CqqvhkZJiQER/tGbQ/O/M7e5HijXXXisYpzIBnG5Xv
         B4QhzW5JpDpxuUwhl6Y7P1jfNrqhFbnA4kAz5TO64187M+Hy78C32N7j+5PULohg7iLy
         B9TlqKowEhoSPUHpTr2ogRmEEIJHRat0heMeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390774; x=1725995574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRYQuA2IuhmwnyrQ8YBT5Ts6fvjQ9S9+/c3CTINRklQ=;
        b=AwE5P1zvDGX3z/7qTiH4EPjV8Q3L12KJjo9Q2qnkTVAD1DcOCVIdajKTI9njRJ0Y7+
         ZwBUR8zdHZ3n9mRethaOhnt9diImhj/rjX+WoiMokc/1ekC2siT/vmuElJO0un3Yc4sq
         MoKIRuISVRHJLJjXnzeIPg+t8reX8kEFkMx+9HtRWEEOc0812rCPb8YtYqmShMcLkDWQ
         2hB4Xb7s511NeqO0LtdLpkbksX1XKNGXUksHdvtKH+EZ7tixROWFEOOnaLVO4DTR1w8F
         A8CPudeihgQGpPH4z/WB06qb1I93zRn6BFX3FEH2wLoeUJNye7MN8a7r6ubWdF/qIPOW
         AE9w==
X-Forwarded-Encrypted: i=1; AJvYcCU/UESY8RG48ufNGyS3xXVbyzxkr2IJSsMalnf0VBWqz9K57sjCVZQxjFGuay0paYI9oPYAbHazSqUiRpsSNWJO@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCKePvXfFXt1FswU+jdMhjINZYvJlpho3mjQ4mOobFPqmYcDx
	tT6iRq3vXGHA0q+OcuLDE4fiQ6V7RP5iBmwCb9lDaxOhPOZ08DmQHiBf79GBtGte9dlIHNUokBm
	XSg8S6A==
X-Google-Smtp-Source: AGHT+IFinlliwBFNbNK0Bdo/9ESlhXw8S+XBdhh3iVZ8lx15f4Gs5nlqRfyeOHwSit0sgfVU2qm5TQ==
X-Received: by 2002:a2e:be24:0:b0:2f5:23a:106b with SMTP id 38308e7fff4ca-2f64d53e86amr14389561fa.34.1725390773288;
        Tue, 03 Sep 2024 12:12:53 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615182e02sm22901321fa.111.2024.09.03.12.12.52
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:12:52 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53349ee42a9so7695627e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 12:12:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxMYSYYEnK2tYJw8fGPZuYz6z2alQgvhFsx0o+lQGmPHHvL5uO8URA/0MpeJrQoYtEylA0womKbfI6BVgTJwgm@vger.kernel.org
X-Received: by 2002:a05:6512:3a8a:b0:530:c1fb:5192 with SMTP id
 2adb3069b0e04-53546b335b3mr10741607e87.16.1725390772215; Tue, 03 Sep 2024
 12:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com> <20240903090843.GA17936@redhat.com>
In-Reply-To: <20240903090843.GA17936@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:12:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Message-ID: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 02:09, Oleg Nesterov <oleg@redhat.com> wrote:
>
> but with or without this fix __create_xol_area() also needs
>
>         area->xol_mapping.mremap = NULL;

I think the whole thing needs to be zeroed out.

It was always horribly buggy. The close thing just made it more
*obviously* buggy, because closing a vma is a lot more common than
mremap'ing it.

Either use kzalloc(), or do a proper initializer something like this:

-       area->xol_mapping.name = "[uprobes]";
-       area->xol_mapping.fault = NULL;
-       area->xol_mapping.pages = area->pages;
+       area->xol_mapping = (struct vm_special_mapping) {
+               .name = "[uprobes]",
+               .pages = area->pages,
+               .close = uprobe_clear_state,
+       };

which should initialize the struct vm_special_mapping fully.

                     Linus
