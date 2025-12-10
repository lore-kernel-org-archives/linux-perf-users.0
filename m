Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF91C6B4
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765362279; cv=none; b=cHwyqARvoVSBFc4+7lGwi5n4RHdiclInK8yPWZYpXyp8DPRWxSLQal4OrVInIlNl8raEyzo1OdYw8Sjsr9XePIbojhujiLeqkJsghq2idW4FhwybPxMostAevrirGQtpQwuUxIVyFhahipJ//1V6/Os5Byr7WeW3Hp1A0GEdVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765362279; c=relaxed/simple;
	bh=ip2mcpISMQVq7EhFi4fEI5nsd5KV6L2+/ysnVLgJ+/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hux2v+pPRf1E35iQPkP6EiWjUeiC5EbKZRrVgL5uTf370j6Uxp3gR0Wh2yfiUW3TMaaInDnyCEoiK+wZZHo7VVhXzOt27AJi63DcI6hfow4DTTvc1qcUs6OncpB0i3a3DouoV8UVuHi5rXY8ygtpprsLDUFRLc0jJdTXSqgV7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWoNeOu/; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWoNeOu/"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-598eaafa587so1735892e87.3
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 02:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765362276; x=1765967076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip2mcpISMQVq7EhFi4fEI5nsd5KV6L2+/ysnVLgJ+/o=;
        b=lWoNeOu/ShI6uTkA//wEYm4JBqbeqg3XmM2D1IYpWWMq4VSTL6FGCKcF70Z48QB0TP
         LRA6YiWePVPvKB9G48Sm9n9CS6pKezuqERUXjd4/wS2E2p0pRGT+BqrJSFHGJEU0uPX1
         SR7wIbsKW1iLq1Uw//DHYz+sOo/6e2bJVwNBHd32qt4f5iFiFGR7jIuKIvXuAf9ggH/V
         VAxkDjeSIltU6f1tb3FBV8jIdTb8MHsgbnYpck0ig3Y0Df2AnfcsoZtpEB+1GPvsD5Y8
         0TJm8sOmiqmbcbuef906nAdwPa/zdSCPYibdL8Rz7rpSTfOIXw6in6iS0ftBJ7NNTmGw
         LZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765362276; x=1765967076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ip2mcpISMQVq7EhFi4fEI5nsd5KV6L2+/ysnVLgJ+/o=;
        b=iYMeBAbcX795MFOqt/W1cwo0wKnLLuebCa68hx6EDljsfhKPDOFGNTi2/67EwjDGW6
         ThSdzsvBZv56mUH9fhMoBaZH2VhMeSwJN7ZsJ0aHRGcUpFshGs+xSlv1fSEcKEXpXX7p
         Yd37Uyu0/dgZ1A4eKevTh1tLskllfL8ImUWivPxeV6DCUBXIXY6GQ0YDPw1+YG5Utbxb
         n1N/6Gqog+mfitMWtWUwMo8DRR67IrqbZZCn5lpeOR/PGCHocnnteQCbNqfXlh3sv/Ka
         9fq92AziVYLdnte+qeY1tkQdTdYrzjfDGLK77kU7a7h5ACJcnGMju0tyHWmqZqmAefhP
         JgVw==
X-Forwarded-Encrypted: i=1; AJvYcCWi1wh9whzBY+lAHwZyl3kRohAMSVTaPktdW70BbEqDfQNIrHLTtta+D414kmTzFpCIqH1X37S5FPkvK9bg3/+C@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAqd3lh+QXKfvjjDp92u/shhFO6K6483JSmkPdlJZHLknTmDM
	Fs3ZSt0SdS+GhTnnm5LknZpM1GIpxtuZpedGcnoi/4gGNsdbtZmhVqqhz9/ntJX5QSNzpl7RNE/
	4Aowa5QdIMI9WU0sNEWrkQfHrr1IMN9o=
X-Gm-Gg: AY/fxX6EYnUfg1n5o3KjTaaWSW5Et0/tQt1XEe6fZC4gXMuA7cQmnDJZEer03PVtpbr
	QIYxFOPbpskJKnJwVnM5aR9UJSAL2pTw9Ld7ycPkuZpjE5Z4HriTF+Nll45H9RO+Uibe/XWzs3t
	dJg8T58zf1/qzQx0v8C+k/WFzpiMSbq7Gmr9Wg7HSlyLO659hJMjYuWxQgUDgVCMwmkdgntJIvU
	OArUTasKTJd+HCIEkqY4dDgVu7dt56Xh1ts4kOUdsT9F+iSHkDypusL0HDz1XWL/CUPcXZQ
X-Google-Smtp-Source: AGHT+IFRDakaVp44XD28znKESLvDIxoVQ2rcmGunW59uzXCvxiK9aqNjRVeJId3809Vu//u7jaZ2pT7DD56wJMQ9xEc=
X-Received: by 2002:a05:6512:39cb:b0:594:cb92:b377 with SMTP id
 2adb3069b0e04-598ee4cc14amr854982e87.42.1765362276134; Wed, 10 Dec 2025
 02:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124072310.3592-1-hupu.gm@gmail.com> <20251125163920.GG724103@e132581.arm.com>
 <CADHxFxT3TfdfLUYUqDqnx2ZBzn9uiSoDpo+R-u_t2U9OCoHRew@mail.gmail.com> <CADHxFxQ=RamXerAKMDQh_NGcgVtZ57yOTgXDV4jAAqcMy+Ef0A@mail.gmail.com>
In-Reply-To: <CADHxFxQ=RamXerAKMDQh_NGcgVtZ57yOTgXDV4jAAqcMy+Ef0A@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 10 Dec 2025 18:24:23 +0800
X-Gm-Features: AQt7F2pbUooc7yeAwMly441Pzug45hLrLAYV5OyzkxB4q7myjRxIqd8vNUDIkU8
Message-ID: <CADHxFxQBLDhKEvKNAtbpFzCpiYuaeUs3UUdnp9trmK7Y+kr_HQ@mail.gmail.com>
Subject: Re: [RFC] perf build: Use self-contained headers from kernel source
 when compiling
To: Leo Yan <leo.yan@arm.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

RESEND AGAIN

On Mon, Dec 8, 2025 at 5:04=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> RESEND for your attention.
