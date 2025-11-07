Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6711DDC33
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Nov 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479348; cv=none; b=q2fWlc+vneLAmluHqMAJd+/hPCfIoLQ1NFALXHIEBpA65WkfFz99e4cW0YDjb+XDkdBni+da3N38vRgNiy1hymblBHquA5TNqED7w4gIsso8WQSNvjw8RTkcXxbFGBhgG+1i7oeSB2TcOs4lDMKwUpOPAkRXYGOsWXzZWlVEOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479348; c=relaxed/simple;
	bh=ALv3T0LdZlAXXjuCf1bRzW5Nc+7vXsSilbrpqKU8F5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmNjkr09n/D38QZSKeTnJz2qV+fdLcn2m3uF/hNY3VT2rYgfDluXvobtuAoOIkxQHZ7BOzbOUCSPhe7mcCwrhEru4eskZ/qUULuUc7ItOsSKeamcXFsX1EW4zUGfUdQ+8xpOeCTOgxmiyHCPx8X+PIQ7nX52YjxZpFHzCgr/010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtF9BvTw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtF9BvTw"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b9a2e3c4afcso40762a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 17:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479346; x=1763084146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALv3T0LdZlAXXjuCf1bRzW5Nc+7vXsSilbrpqKU8F5I=;
        b=QtF9BvTwO99ypH/3su0OUvoDSKhTro4nJ/FhDiw53wO84/KwdBROsltJfelyjWV1/X
         h5rygbukzif46hJpSYDoAEkQ/B+c/1u9fXhWm9lKZMr6ln71w7MdwWNcO6PwCaN3xmfn
         iuQA8OaDgsi8mt3TA35PRq/5W2rUBKVoVtGErYfUHnIr/exNiqmv5r12S/gUbwlj9Y9U
         a+zcUWD1RpwVBYNoGI3tK0wgDX1aovolFtQENUoVi5nNizrU9gImC7gVH23JeMy35fTu
         K3HFi81dfz6sPbd6IlfSTl45vbVvOV70+i30ezUY7VtglPVs9aAi8lmWj0dlRUeAiW/H
         HeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479346; x=1763084146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALv3T0LdZlAXXjuCf1bRzW5Nc+7vXsSilbrpqKU8F5I=;
        b=jwd/hnfOjRDZGfCG6ufPhlKeAoecQimn+eYknxWY5nbzrjv4s+QUb6+02otThgL/hm
         hlu7tK/Xnrr/rJ3INI8//juUvt96PhjOr4ViCVfKLpMmOYSfbecAfJ0HRgsSdJtdXAah
         DnH2RPan3IM5hSnB8/KUVBi07lBqXFBf+97l3aETlrXbiBvN6dDY6Rb1+1UgL42C3y1Z
         /81jdsxrENLnOrSQHzWT+MLamRglISlsCbz1dFTjGsJBVCrmxUEnrfYOhxK63T0V5dCf
         Utz/1HPbG4DwgnRQNvqTLwu0G23OeD3u68rTEzy6/kLYDq5Rsu2wluMtasV/FkWqU+lg
         1I6g==
X-Forwarded-Encrypted: i=1; AJvYcCXhZuBH2Li0v63NUAdObdAzvidOezAbS2R8OqVLc+hO6gNyAUzwwuT8dpGedVa92lPsTZ/ivntccIRJ1nx6+Dzm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyma6AS4BX68xZhFp0dL8tqZXher9mwbfYOCt/V2UG1PB9eSZ1i
	e8PlefYsEDyxel6KDta6Zvg5e6R3+DkpfsP2XOPgk0Yuydg9WNii4M7O9jt+XS0MHk2/EOm3cpA
	HzObB7BnCrVRRpdhB4lAwL6XRgKZh2xg=
X-Gm-Gg: ASbGncvnRDy57xBqWJ9bm5CyZSSYs+FRKO7FUrGASr7n6+cd+PW7w5FtfHepQkdYQSU
	v3wd3+XWA1c9nhqThxptS/9BjDTDKQ0fM0XOuojNg0F/pF3/6cLgzOSlgfrK63wKsSpF0x9OXYV
	0wNfGTutN/3di7/dd74G18cGswuueZK1vm3cFCXqSC0dfB5YT5TD94iAEpXGF0Zd4cyMKnwOaan
	QuaMIMxANzuQoYJI0Fdb21Pus+3ldOiOTSsDhTk2mwYbq+Ju08tfDIv7h3P5OTwaj9AS1f+B/ou
	lL4uH+KyoqDCmMQASuZZlXe83yQGt/x/j3GeDIFnGYGIawg1Y3XvUpR588FmaAgoGt8RsWg94KH
	ImFY=
X-Google-Smtp-Source: AGHT+IFdOCSY6O8qmuLhpo+egzhILHqwOsqZrle6tFjkwWMOjETCtWvvAvG3V2hIcW/LcQ1fDLv4kKGz0fqfoB3p3m8=
X-Received: by 2002:a17:903:41cc:b0:295:558d:a464 with SMTP id
 d9443c01a7336-297c0456faemr10946665ad.7.1762479346436; Thu, 06 Nov 2025
 17:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjua6zkEHYNVN3X@x1> <aQltxZIVd6w5VNtI@google.com> <aQ0ERJiTpiA_rL5D@x1>
In-Reply-To: <aQ0ERJiTpiA_rL5D@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Nov 2025 02:35:34 +0100
X-Gm-Features: AWmQ_bk2zd2IkmzGmtFBN6lT1ctf4sW0mHoVMUEeA7J802zxHrPs42dRjI3qLOU
Message-ID: <CANiq72ns1sRukpX-4L3FgqfJw4nXZ5AyqQKCEeQ=nhyERG7QGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf symbols: Handle '1' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Trevor Gross <tmgross@umich.edu>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:25=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> So far, '1' symbols are Rust symbols, in the Linux kernel, for unnamed
> closures and its prefix code checking for stack space, Miguel, do you
> have something to add?

Wait, is `1` the symbol type? I don't know what that is. That column
in `readelf` isn't the symbol type, no?

And if I use `nm` on Fedora's `vmlinux`, I get a `t` (and the
`System.map` has the same). Something is fishy in `/proc/kallsyms`.

We don't handle the big symbol double-byte... I will send a patch.

Cheers,
Miguel
