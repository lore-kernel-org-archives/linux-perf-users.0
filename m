Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E533242D7
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626737; cv=none; b=FOOgYIQJIwDy+AGnZjaSD7bHHkaeXYeafRyHBoe2A4gocBGMpPnwVf4GheSW4YLwWs4Z9rrTvilYHj4ReFeOcj/U+sqN255ug/u9GBcL8gPNX/4Xct8gI2JNFeSk4JkUuEK7FnzkHQ3ziOeY8GBYOMEnka9j+Rlcpo3/0xLYEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626737; c=relaxed/simple;
	bh=8J4uovh6LVzVO2JBajUxlGf7AdBtM9vIR9LvmKMVaWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYU6TFDjoNxeea2lctOJXrjW+zGXR0nNclOvgL/DgMa+unzpLWjqVxka1xIQt2L0N7dsZb8orGCzzdnLfuQwS2W3LHDpTsxywxAlCoIIJUURBhlBIZ0kOpkBZ76os7pHqauIzgx+hQuJFGLjpUqJnhP+eYbD49IbrKXsELZiIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US0IfsTJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US0IfsTJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8eafb515aeso483646166b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 00:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770626736; x=1771231536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8J4uovh6LVzVO2JBajUxlGf7AdBtM9vIR9LvmKMVaWQ=;
        b=US0IfsTJWHAT1BeyfF2bmL+6FxGDwGaLrjUq99Ep3cAvao5CVJujE9k1aaynEDXgKX
         AYs/+54FhfSGvAdizDJE09yEUInjzxGOF0thziP1xd+KnuzhpmDEi5F31/poyPAo803g
         kotqI6J4lfvMX9Y0M+KQouYw1Nsum7FgGnnygrjXtTY/Dx28SznkpNuA5nbp20GAB9Vt
         ZFy31eG/su0a//2mCI8TVVLW+3R84JoUzajCYes4uICro6HMZmDQd6gxZafhyi29hhSi
         juuiqMYZ6ynXiLSfPm70WaUNsIzik8cNVJfSjqCEySeELmv01hnQRHkHHAAn4XQeBrFw
         XB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770626736; x=1771231536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8J4uovh6LVzVO2JBajUxlGf7AdBtM9vIR9LvmKMVaWQ=;
        b=NMzPTLzkIiXwcuriOKQAGnyaKosuB9aPhh6LjMHUASxarekBMtBmCqaXjtD9izDd2i
         OQOuMOfWRWShi6VjoBSaVq0pZ6LTItnbuLvxZvhNNsgnmOfqMNMf3cKR/qlfG/55dNKl
         im/iZmuSwCND+wEcIaHdVaXrTsh73TOMPMaW4cGfO4I2ekyJcYGQgFHMwrwRHkMYUJIL
         ZyC9VJpWGz+QKAcbP5h+CcxJn5zw5T+VYbCscGgYwAR2IRoMxAP6n7lxx5cNkQB1fZ3B
         /pLIYG4kQrjpvdMyyCUHJpQWpwdf2ApNPxKfwBg2EN+AiDzwkVBXEuY4uCGiUlQQ2hzW
         8b8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5R+qAlalbu0LxNPrYiO5QiTdk6Ex7SVYSrrVVkwFJn1CM1BtveY9/8IGHEln37QU/7jUCYyf0eK0mn85qXpTC@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxUW2sjYxyTkIcbLLE/9M/kXGddX1WaTiLMAOu8s1M3iuSv6k
	vrM/hYPeKcBvHpvOOQlwi/SLIsCOtoAGOhrO9NIzVDwk+qq/BZzc/3iw
X-Gm-Gg: AZuq6aLrNlPGovFDp98zcCF58BUIXbWLgroZxgKLkcVIbBXL+XiYytducKxitGt5vVw
	n7+xZekCT04uGTe15HHCByHzxXBJyL/UHySdYRmn5rFwmEzkSgfzPTAsQpY0mhgKPaLDvmLYI/y
	rfE2v7AindyDXEyu1qXh/DCVg7Oc7TDyapqxJgDAUjc5ibcRrqj370uz6HnWi0pIxskAvr64Jaq
	RhnJsg8CZiHvIZcgvRa6KOTMpbrSenYtU8hJSqEGlnDtIfw4WzYCxUoRp7DFADYpRIfyPnxUOZM
	7i2bK4wqPvL7E2ws9ZJrhGHvFgS3s450zVk21GoZrKZUdDt/cUqJuMjL9okRXenaXTjZ44Cz0KB
	BkpzeYw+EFcNYB3v8JOxA5SbQ9u7SkfCR3WfyaVgVjzf0WpPLEmPPV3VXUW1WYs4/x1kdWBuMrA
	ubivv+O+naTZ4Hm4kP1sU4kfg4DdKvKOlfWgNYaqncekHcIfZaSHsC31sDV9Tik8MdScq3Ldvju
	VRtqNBUfOvXzXE1nbpAsTAz
X-Received: by 2002:a17:907:7202:b0:b88:6309:c300 with SMTP id a640c23a62f3a-b8edf34b334mr622337066b.39.1770626735269;
        Mon, 09 Feb 2026 00:45:35 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacb387esm361482066b.37.2026.02.09.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 00:45:34 -0800 (PST)
Date: Mon, 9 Feb 2026 09:45:32 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, linux-perf-users@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Rust data-type profiling working in perf was: Re: [RFC PATCH v2
 0/4] Test annotate with data type profiling
Message-ID: <6i5osof4lst2rjnta232tvntpbufrpzihp6jicsysob36pj6ss@6acco3e7r4ym>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
 <aYigHLZtXooznMB7@x1>
 <aYig1O0-5yxy91la@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYig1O0-5yxy91la@x1>

> On Sun, Feb 08, 2026 at 11:42:28AM -0300, Arnaldo Carvalho de Melo wrote:
>
> Also please consider adding examples of output of such new features, so
> that people can quickly see it in action, data-type profiling for Rust
> seems interesting, right? :-)

Agree :) What would be the right place to put such examples, somewhere
in the documentation?
