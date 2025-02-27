Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6A1E5210;
	Thu, 27 Feb 2025 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635001; cv=none; b=N4Vw70QRy7Qy41HxyXZCLMpf7dPaiwmRX3c1cfwf7HX7hqBeT4ybQlO8omvBYJa7oRWHQwdEv0zHK1sHggvyAUXGcWHT4+aVaS201LcZ1d0snTgcxCGRMXUcQ6TjZBc/c1OP1a/5Hx1a/2BzFoxLNo6R4DA2Y4ByUpTyeunQhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635001; c=relaxed/simple;
	bh=OXEwbgBYKE8S/zM1xUw4mGVB5Z/EPkhlOj/ZKYAL2hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8O/YPC4jktkLjCOG6Q30ON3fA323d+jN1Qscqnx3z2t2dNVw0Cu8BWw6lCLt++Xj+B+e2GSkX1LfkUTu17JtDXyOvq4he60opunurWdLmEMA6jpgUfER9ELxKDKrDm5Y4roHO/H3IJ8xlbZPrNHfgGWpI+dNQl4XHyK56bP0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixhpor0t; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixhpor0t"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fd3b31c860so2308037b3.0;
        Wed, 26 Feb 2025 21:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740634999; x=1741239799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXEwbgBYKE8S/zM1xUw4mGVB5Z/EPkhlOj/ZKYAL2hc=;
        b=ixhpor0tLWPaI8rL+LXoVdrsuh699J6YbiY2jqMj3uLbzwjmDNAc+cqvRemCpCtWgO
         9PJee09oum5G96Vq/gWsOYHOzlViivoem6D+nlr1cFaHQ6YUVNOgTaVNFd5SjZ/r1OBw
         LqNnUiAMpvA/bMAK8h/XMFPcgop1L1H3up1I19q3lavKrERqUBGMESm0ut+H2ZByMMiu
         w+UZi7rYEJ2/Zns4/ieclPjT3vIPTC53/FMBrFk+RNkHY8kuBbCZZbQOSVHq676NnOdx
         s2J5C1wfxre7H85WBLrw4Q9JcftJIXSLS1S9069IjUbXoVCMAsr656DhI1CW8ZTvVhhA
         kcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634999; x=1741239799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXEwbgBYKE8S/zM1xUw4mGVB5Z/EPkhlOj/ZKYAL2hc=;
        b=WO1rNRw/xzup/ukrOFcozWF8KqRDoBZK9dZnSDinsfbzMdY1rmwPxARQmyz753OYxE
         zEI/dWGbgJDruypbVR15JwQJvAO9IWZLE/8FzX3ciU9Q80XrrxRH3WYBCD6uK+iKbVJZ
         GxUmXjg8pG0aKwzJyK7YJFm9sqBTXeRkb9kCCxdIGI2M5QUgDG3pIhjdwyqFWQzZisi1
         aYHi+wMqkT03AbRQVgulAzFdAJLRNeKvlPG5PLrfpfgfSSBUxAAxITRP//aVZkrxXMck
         DP2pf/7bC+oOoRgdh/xI/k2QnzNYk0/VMYqGUxSQ0QnAC9iPZZBDdCZlnLqXZqrXBocD
         ihIg==
X-Forwarded-Encrypted: i=1; AJvYcCW9W/0ThR37uskKyQeNnyNgGuWy9NR+xBl+ijAUAnJo3UKAiNIJD2B6OEoOUx3zPhPW1jHvSIrq0MgmUeLnA0uEFw==@vger.kernel.org, AJvYcCXU0w52Mh17fJBTEo3QW45sGYEJYlASf1uuXhGTnhhq0YND6qim15xvgGpbGx+K/jQmsdVeJX2oL0W0/Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7afveW9XHBfRDDXRLD7r6zyqx8IIMwUQ6X9thohYcyDBV0TVL
	0PyWeSvE1jp26LExYEiP+LijpzFu9LiRkQq+Id8kBeCo8UjL4MFTRAygmZEZRaOAX37l+yL7XVK
	wAgoon1DF/FYcssBp746yElxxzCk=
X-Gm-Gg: ASbGnctGYuJhlyS33Zz5uUGVNIc3sZvWsMIrGLUwUwwjTNauCWwonkFZHtvxDEhjSUT
	zvt1jyNEUbli3+JNKJ3o8B2S2qIcfVP+yr1QrL31c4t5nrmZsdkCYu8lO53JWkaUv3Jgc0g9Xab
	tFCb5Dtw==
X-Google-Smtp-Source: AGHT+IHXCeW1GtEf/frs5lHIsyl8/RHBkGVPpFWBwqbptZeyTmTqAEzIv+ZjAXXJrzl4alptUnmoKGer2Yi9Y1t9B4c=
X-Received: by 2002:a05:690c:46c7:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-6fbcc85fbd6mr238862987b3.32.1740634999130; Wed, 26 Feb 2025
 21:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <20250109075108.7651-4-irogers@google.com>
In-Reply-To: <20250109075108.7651-4-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Feb 2025 21:43:08 -0800
X-Gm-Features: AQ5f1Jos-61el6BK6YgMAHGcR2psDC3RY_b_HuUBAEvJ26781ZFraSGFq86yoW4
Message-ID: <CAH0uvogRE7hjGqKbAtUEciDh-dn4HRuCBu+AfYZ9m-tRdNvw9w@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] perf evsel: tp_format accessing improvements
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Thanks for fixing another bug! :) The freeing in evsel__exit() is
present as well.

Thanks,
Howard
