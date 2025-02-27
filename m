Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A217A301;
	Thu, 27 Feb 2025 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634850; cv=none; b=AjCJhPg4aEMjTn9XuPF57jxH6u2+uWpYNoAlzKRe8vcULpFd65ZoB36xfwNhT24ci4o4QTOeV5WHJD5vECjv1/3/0cxd1xaa8iX5bwT1IakxGnMV9tg3cBJjBvYqP0geE7b9dh1KVJO+aLPfCSj9nrngmY+QFf+Fd0vOWiWvpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634850; c=relaxed/simple;
	bh=OOYxUhmeLINl/mx2gdk+NoAGXB6QcbSlnxwbQ1XbYzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHoQQ5F2JpQnR0Kgo/4E2rVrTUBPNDkUVdvV3nsynUR6qWB64U6pzJqrnjilRDz2MTmIkyj749j7cuW38c0JVQNloOu2tfqfg+j+sS2rFfvzdB5OgOuVLy7ffTjQAG4WdLQNLHqSq4rZakphQf8btVLozT/GRckJnPCC2vbEfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY6PMFIr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY6PMFIr"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f88509dad2so5680177b3.3;
        Wed, 26 Feb 2025 21:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740634847; x=1741239647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOYxUhmeLINl/mx2gdk+NoAGXB6QcbSlnxwbQ1XbYzY=;
        b=hY6PMFIrZg/5sSyURkn8sdMkdoS2LJO3Ay9oItzjcwQLSRjzWKgwoeVZ9gAs/J+unq
         MbWT99ZvcO2u9HHIFyHxDunmMQ8HZ1D82oEVpc2lFqI4SorUpczwx8QjzRWPG1S1paD1
         /Mfqb3RDODqJl7KNUSPxeMe0pwkB4dus8HalraDX9Hd8zKjB//OkexQ0IeLMU8rm1xB3
         l6uKYSQmOCRCr1rGyHfr9Hk3digo01HfxanYoeCpuBstESyIJcs+CZAnS3FJfDcbHre/
         NxnuBYNTIAGxnocuEwQpJMHmER2Yi4IA4/33mfVnP4wWF1VxoT/O2uEv5u2Hq6MI9aU1
         oxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634847; x=1741239647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOYxUhmeLINl/mx2gdk+NoAGXB6QcbSlnxwbQ1XbYzY=;
        b=CTFwJ2Rh14ftSnCQ0n8cRPlTCey2R6/PxP33rHtCmb4AQKMwBhQZ3RnXC3x9ujeNyq
         net2uUMJMbi7UqgkruTXPZnHiajT0G0z7bGYlNZSeY4RFcpvFfumOlPVf5ZR7OLSTHkj
         mPdTTc71l+DioCEoa/D2MksX5Vugm/UFD31FMIAAlWB7UOfxjbC2vtkQtUROH3JimZ8r
         iwFOya7Y3Y0SNW+Obwwrl6uQd2YGNPNHnwIqr3InXwc31i5SXMWxM60So77D/rRE5FSa
         VWu7c5klM8/zzevwBrJFhSKSNJTv92ZeKV/farydEIQrR2tw9GX6GnqTLcHRdZF9D0Ik
         KyYw==
X-Forwarded-Encrypted: i=1; AJvYcCUDxrCZ1qmFf7TZJXK0H7c5JD5tZf3WD9+GKmc6zTPzXWBJmtvBdy7m7psRUkkzqvdgDXfHbHwYLf/U3HSX/HmKDw==@vger.kernel.org, AJvYcCW3Qrwc9ocPSoOnItCQtKz5EK0NnAsn4cioxpVXkGs7p6aFWMqIejT1XevnQDRNjGWxU7w3t71VU+j2d/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWYDVIELt9EuE/XfLYFqhw0K04SHOAIoUYXPn88+etdC6rUiJq
	TVPF3fhvB1zLaajjQilGlYxE8h3LHxcvEKUVhIXoJMEhUca8KGjlkUjSFpXWztJKGtRrtQPzfv+
	WtjLr6ttZpn6VDOrmElxha2w/Eoo=
X-Gm-Gg: ASbGncsSLMXAmjMjwDE3t807MJiDh+tuIy7t5ThQ1ogNZRrSsmfiYVck4ARO7Z0GCZW
	hg9C0XR6N/no4sTc3bNFtf0JnabwnXYym5VOdSlntQ/OV56VudqvoKFJLTfRXe+RFLQVu8WrTiZ
	6WDEgXRQ==
X-Google-Smtp-Source: AGHT+IEiCwzUIxLiT9ApM1O30LFyhfyMY+s+1Pj+UNjNc5YoGLFOIFD/au1usXKgRzsp6uXp7entrnBDdLRzn2M2mOQ=
X-Received: by 2002:a05:690c:450e:b0:6ef:9e74:c0b8 with SMTP id
 00721157ae682-6fbcc7a3a77mr213751177b3.17.1740634847408; Wed, 26 Feb 2025
 21:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <20250109075108.7651-2-irogers@google.com>
In-Reply-To: <20250109075108.7651-2-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Feb 2025 21:40:36 -0800
X-Gm-Features: AQ5f1JqiOTOyp_dzIzvx-A2UxBFF9mHcQnsAg2XK_GhnzVqitRIlrwczXqIrHII
Message-ID: <CAH0uvohxfk0wYv8NB5i7dZJ2+0PX22iqVAJqWLGqKykrqC-RgQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] perf debug: Avoid stack overflow in recursive
 error message
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
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> In debug_file, pr_warning_once is called on error. As that function
> calls debug_file the function will yield a stack overflow. Switch the
> location of the call so the recursion is avoided.

May I ask how it created the recursion? Too ignorant to understand sorry...

Thanks,
Howard
