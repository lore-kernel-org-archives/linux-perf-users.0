Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C01662EF;
	Fri,  7 Feb 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917078; cv=none; b=Tml0zKUEpSajjiVNupf05SPmEHZ6qxF1iDWiinmf1ZLinQ+CGCS7KKDU3h3FcUEIDvCi4BV835mGee9zbKR9kC6p7ZmMSO6wNg7a8jN1DzmhQkYYha0Pr6HMK8VPHmASabD5e+nlfTPE+FvnG0HvIR+x1OiZwDlqh+shE3p+w6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917078; c=relaxed/simple;
	bh=Cv1JZxbY27+iAom/VJlhnZ2cyy77l6yixKXOFKIzKuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okedtdxioq+7ET/2rIluzp4OdP0calRXdpqw5Q3QMUQw2lQSbqhOGkIDeKHkGkWzJODwb326Kl4cYgqSn0vVJHHS9FjILjnl+rwSGBvFVnuWnO91Ims6aoAo84DGILUvOiAXLyUAoMy8gMTDSwbMBUOsT+iB5Meg3drmMBYMMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg01+mbN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg01+mbN"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab78863c312so105331966b.3;
        Fri, 07 Feb 2025 00:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738917074; x=1739521874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv1JZxbY27+iAom/VJlhnZ2cyy77l6yixKXOFKIzKuo=;
        b=Xg01+mbNdddJX5GejHVxGBfoSiWi/tfU49cgGFTPvzKjbjI2YGnHKHz+Pz5zUywBnL
         VXi6mnkdXB7vS5rDhM9RInodsjE5i24tT0FvYk4K5j7OB2t2UZ1VUHZo8hAUkjnC/MIW
         p9jT5zc8jL5EJngVfXNXVpwt24kaH29I3J4xg3maelpK/dMbjIBoGtkteSSwc4FaURE+
         4kpF3W/AzYi0cx4JLTpzw7ffQ1ATmWUaayhaZfJ59btbTv7XVgY8FbeSCXQoAAoqQauf
         Ase5yh/5Gya0XkAm+Mcl3YhAgGpQU9NHL31tE1pCAat0NbbC34eIIYtv+oKybCPfLH49
         DB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917074; x=1739521874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv1JZxbY27+iAom/VJlhnZ2cyy77l6yixKXOFKIzKuo=;
        b=ZdfqYPwliL7VgJtSVw+uDtN9hPDe3k+bztqWQrPvyrjji4CDJvmkzbQNg/7mtgT7CV
         u1edUwdIwNqP4cSEBOfxx7eLAsb7U4czd/gj9tPcEM44nIuYMURYb4TFxYS311GHqt7a
         /NboiDnBrzVq73cKqt+Vg86P193BAvoUG4SHfub7vAFbvg7+EyZJveTgBnM2CRT1KDP7
         +u6mMAYy6QI9204wCJUH9qt2yIhGhL0HoaeCWATlE2zsE0YvtlENVr2CvygzEvR/37Dr
         6IiA/OVc6fRJwDdzp6P5gEjOOhebAZGleFwu6zORyco5LN6qvN+exjG1zt7JM0k6KXmm
         EaXw==
X-Forwarded-Encrypted: i=1; AJvYcCU3HLcC/1JHm74NU4oHTT55I48bXA13uwa7qC3t2tfSV1iZ9QXyYAmjwGNaEjo50VNM5iuYBwCMS2Y4B58MIhIa1A==@vger.kernel.org, AJvYcCUuXpC6UkrfJRbt1fKEoLPU6iCH7jkAbHWnHkoy6YBtCg4dDSb9LoSPbvEuMy9hqDI77zBjH303VUxVIpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApPf3F90l6ghgw/L0eXYE6Lk8f6wgQ0yTcO9yLeWEaFv94SLi
	TFCXrNdGvPVgbvBXujydGf3hpcu8u2hB5XJPHdculSjQSZQaLFtwsLd6SqYqyIL+YTYMS7qRDn8
	wNhjqnL9dXhYi0wXCBK00zKZNXEc=
X-Gm-Gg: ASbGncvimGyej2ts+7I/N9r2skfxTrr5nN+Wu/Thi6C3ORT+GGX9YxCqyQF4ioBzVKX
	iHh9hvAQBWf+rB0aCsHtnEJUn2EyBqViB5CxqVaIe1IcoqqPDn+Eh6sujtQ6I5fKUy6a8b2NUug
	==
X-Google-Smtp-Source: AGHT+IHqPc9tEkDT1Y/9SKC12pjyslXFDjbLyL4Zk/0iwOsBjqMTXG1Na7xpqIsuf2gUbXNq7DL1NQ2Q4bfcB/tygy4=
X-Received: by 2002:a17:907:d03:b0:ab6:50c0:7798 with SMTP id
 a640c23a62f3a-ab789b29e05mr194837366b.4.1738917074052; Fri, 07 Feb 2025
 00:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com> <CAH0uvoj-aS44f78iQiVqDZiR1mN5SHcXgR17_Lnu_b5CC-ZsPQ@mail.gmail.com>
In-Reply-To: <CAH0uvoj-aS44f78iQiVqDZiR1mN5SHcXgR17_Lnu_b5CC-ZsPQ@mail.gmail.com>
From: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Date: Fri, 7 Feb 2025 09:31:02 +0100
X-Gm-Features: AWEUYZlajkvDX2eKfAY5C5JqY_mzQ1H4xbRQRc83I3_CELTX4-DLdAueLmA7qj8
Message-ID: <CAOQCU66wgpVq8k6MX4hKXAhHyufXsg_nTeQPs-bh9jMEmHzjbA@mail.gmail.com>
Subject: Re: [PATCH] perf: Improve startup time by reducing unnecessary stat() calls
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Howard,

> Is it necessary to constify dent?

It's not necessary. I have used it because I wasn't sure what libc would
do when we wrote to that memory.

Thanks,
Krzysztof
