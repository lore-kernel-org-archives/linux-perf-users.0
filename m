Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942062877CC
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221501; cv=none; b=ddiHxKScqRYzarrFOGsBmK9bub9mGfP6M9lEJtEjfwcrwreTG0VaUvt8eL6gGdLZ+FbKPZUc72yW6MoH7Meu3C0s3sXZclnIc9Yp6wTicQucshBTHEOCiyK+9u1sQCCa47FVQCaMczCqRbqwj8yfe2PA1vIWmYUPVwhoor//4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221501; c=relaxed/simple;
	bh=EngUjsKE6ntaSga2u9NxwJiCa0I8KWoIYhdBjksfnBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRU5zN0Sp3g47jTld7u/gcVGiCE+rdCUw6UeMkI+2xqcrdV67d94q62Xl2Ca8oBuaWmWbA5myTjQTxQHYtdkarngVAPfePSm0iRNSnUxYw6AFlQxefzKVwtK/3AzxFc5admfrPxAxKYq5fZO6V1JryQDJI/wc5vlSbwNSNx/EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UVCLt9hr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVCLt9hr"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so4281a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753221497; x=1753826297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XphRFYGKTpOm5xqnRvI7xsnYVXmfTKHiTieuuJNNgkI=;
        b=UVCLt9hrIkRO21cndqVwG+FcQW3FCo2GmRfwuZDHOlTrI7SNrja+Mpmf7h185ZpHBH
         HJny8RyTGLnAEK7fUBtNYdmPGFyHl8jSDINWskWNGEE2vM2twjUD0oAZ0W0Dt8nCS3MB
         BHBj+GuCntnl741iXcVqJ3fnk3DhBbTd2LN0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221497; x=1753826297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XphRFYGKTpOm5xqnRvI7xsnYVXmfTKHiTieuuJNNgkI=;
        b=jQA4+e3GmTzx0rumeSlSt4Ob9vWrqYHxYgZnbMKxWGejlrdppcpnK2LxkEsMB+pPbm
         3LILTWquo7vIhYHKxYfdMXqBHQjP39/5+nfGnJtUUadiBY397pd4mAe+28JBN5UQJKJn
         dBobzmpNT4q2i/HXcYYjiVd+j1gVgBkU6ydW5BhriJCSvfrAV0us09IiMihgXdnSkEli
         X72Nd/K7YFNQ9756JXvldMH1SQLOuCB0746XFWsZJdHeBcoWpPyW0H1LuMZSn4QLEvOZ
         FEhpwGwQcg2iPYhkmBHAXKjWYgr/T3e8wxXCbFrmyqTMsO9ydlg/1nkU8IF+EK8rlECv
         aCsg==
X-Forwarded-Encrypted: i=1; AJvYcCU5J+5RQQApfa9ilAQuuo+jQOG+0Yo1fVvOM9UJ13oaWCfZT6/T5s1dZfEQNbCJe1tha41eqLzwxOBUoYxSgvFs@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwRUqpN/Xdv3LgzKF/9RW1lfQeMDwBDk161NeAm5S7PwKTWsj
	ZrqJA0bK6nXEHzRdymbC9bOmTSrCMgWhZ1MEEaQJkTfaDylgxdRMj5uHOISvKfD2QapbHbhGtkR
	3XvP2U22Rf+SdZxWRTVxKIS0jFBiO+XK6E4YkSgWs
X-Gm-Gg: ASbGncuu++etjyPNC685fqSrTM+qYIFbvXs2hbIWziYEUthELl+1A0qSS1wHVFelzHO
	QIiPZmP8QtvZ3bLflTz5cIFkWvysV4K4lYXo19SUrT4NUIlTW+r+QdTcvkiEJCpeoThwC7tHSFx
	tvFAYaWRrA3UAaSJDiZgq8wU8xoN2V7QjmfdM830wrCHeb09o1XYp6j90mo8ZNZN9s1Klq9Rh6x
	nUoV9hPAOSos94ObFMoVpy3wAKQ+nxZ3giXC2wemcSS
X-Google-Smtp-Source: AGHT+IFp5y+l1fTW8GtjpxnnyEe4EWyuH/zYE3JF5LoJQi9huRUvCNpCO/HKD9InP/jd87P+NKE1aVh/xMR3qwPcil0=
X-Received: by 2002:a50:cd11:0:b0:612:7599:65c7 with SMTP id
 4fb4d7f45d1cf-6149ac2e0b6mr29581a12.6.1753221496595; Tue, 22 Jul 2025
 14:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com> <20250722-ddrperfm-upstream-v3-7-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-7-7b7a4f3dc8a0@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Tue, 22 Jul 2025 14:58:03 -0700
X-Gm-Features: Ac12FXx4M-_tpsnv6SoYOcaCR3mVKSUiARmyCSX04o5wxXNHMo0oAxmxSQQ0MIM
Message-ID: <CAODwPW-kVcnVtVakXs7aBcwb_nv0bLTaK5PKNo4zmJaJ=VC8Wg@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] dt-bindings: memory: factorise LPDDR channel
 binding into memory channel
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Le Goffic <legoffic.clement@gmail.com>, 
	Julius Werner <jwerner@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +  purpose of this node is to overall memory topology of the system, including the

nit: Might take the opportunity to fix the typo here (missing words:
"is to describe the overall memory topology").

>    - Julius Werner <jwerner@chromium.org>

Why remove me? (Although I'm also not really sure why I'm maintainer
for this file and Krzysztof for all the others, tbh.)

>  examples:
>    - |

I think that's a load-bearing pipe character you're removing here?

> -    lpddr-channel0 {
> +    memory-channel0 {

Just to double-check, the name of this node doesn't really mean
anything and isn't directly interpreted by the kernel, right? I'm fine
with changing the example here to fit better with the new expanded
scope of the schema, but we have existing firmware that generates
nodes with the `lpddr-channel0` name, I want to make sure that it
won't break from making changes here.
