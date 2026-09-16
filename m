Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110A50EC08
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575325; cv=pass; b=ZW3gMWQ20GxdpojB5b/VFw8wm3ZPYLframbHiOQnMuJ/v5thSIivUkbKdO+jwQsKp3QlAzQpoX6QXw0jRvBXqkomOS1ertXk6D/XeJxSvBSCZJB0MBNu00t60S6Qr2/9EjWtFaDa0khDZWKIN08kgutSl6eW7Nh+O12va1G5HYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575325; c=relaxed/simple;
	bh=W/UaRW9VDKZ9nC26IGoc0xEyycGn8uxQTbeedJaZEmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s40I5sujJGjGqkUX9jiUjRg09pqNAtbg1G9qZ7gf7f7czEkMiG8YLbA3LTCplEMJO5pkbul0gGpinpZM67+EKZtIHq+9EPz5I6AkTevWgkRfHQBEeQhFtSElkrZRrOBKFauoyqUdhO5ISiaaxWYkUNAGKKoDYja3R1/yUzghtG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=cbl7N1ER; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="cbl7N1ER"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43ac8d1dso9593237b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 09:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575322; cv=none;
        d=google.com; s=arc-20260327;
        b=sIRgaHz1zA1wyf1U0Yppz7Wd5nQlGGV08qtjalIK5pjo0vJH77ZRvHLnQOMdfkOg+t
         b+A0KqUZnU4ZLAhrgfSghRyXsQcfHFuz+t/3EeLLBwVWwe6k8dksXNE1Wp+7smG4wPAl
         eiRM/HS+GeT7jCkp/6xm0okyH7Jcfdysb50dxROsBMHIORFAIHLKVOKupxU8vjHsaOxZ
         WEcQyIM1ELJ3RONqfpYl2glGrK4Fl/kBiTkJ/LMfOxb3ZVT8PXujTWlXPGX6zJdz37iF
         qDIMFypRqIUkywWPyGgvG51eVTpxewNElxlq6JoEceiFamGkxUIDZMU4ej6AI7RqBXuh
         Ig5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W/UaRW9VDKZ9nC26IGoc0xEyycGn8uxQTbeedJaZEmI=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=MG11QpIYyMkHuboO4EaIpCCxAngxQG/9F9E3s6hgoqu6l/k20fbQQ2UZj2rFuwpoSP
         xg7K2Q8kLzVy6AHmI3R8XE8tMNihGJRLI4BMJZkwh7EJtyBYqgsBPWDhLzdhkNxqV4ZD
         sRmvT4hnKdXLTVVfKZ/+71iUvWSPD0KLg1VrX8Kob8Hsd7RrxAUqOdZfljSWmIgFhlS5
         xFSXOzey89ff2AIJiqF0phJVaGZJQVT1kTsZnDw9HNuszcGN7DPBmbNfE0FaCQ1NrDEl
         TbKG7h0hzARhwS39ShTrtL/d1A/2HxrA0oy4XoKX2zLQDyQWOovG273tw6uuLnAeALHg
         hr9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789575322; x=1790180122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W/UaRW9VDKZ9nC26IGoc0xEyycGn8uxQTbeedJaZEmI=;
        b=cbl7N1ERCtUupj2s8P0qGxS0Wpl7DNY2Mp0AdvSfGf4X6X3vbB7R2STWwGeiumtIbe
         aADIiGMrE4CmE15xEmcqs90VFC8HDP/wqaK5SQeqhQYCJrasm1f1XG5g3B5tSu0mNS+s
         mB5c+AVjY5xNC4sfQKehrqdXQPGLkmYwhsfRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575322; x=1790180122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/UaRW9VDKZ9nC26IGoc0xEyycGn8uxQTbeedJaZEmI=;
        b=rkDqDXxsYF9i0pAZvO4ah6ry3JCyo8Hq3PlEOSgFgqdqYZGrCHa8ezw+s9AlEOx8it
         mIeMn1WaissIArBiDAUWwH7NyzWK7UlW7OKjynU/RrjI0G7cE8VcJ/uO+p0ZG5jmJSce
         VdWlqyP52ZqxgxY+qdWParYQxwhl5Fm+Vh0viDpNwgS8RC38xj+0U9cewT+KhoFO2ZCy
         CvR/mjLKCzaW2UaTiEkOhfQ29q+TZojQRzalBetFDXzmJdPBuYG552bxJcgXVEFMGTRC
         TAAwWHtT5hsHdwe493iPkANbAYfPr5xi2vosuUWhsJS8nPA6JJB16HqEwRiB5RtyXoT4
         elDQ==
X-Gm-Message-State: AFuF++lKryLyV6AujXaHG2iztK3lpt6p3ZQzzqCEMd8ShkLCdaG2jPPj
	uyG8CDN2Fh1XmaBlDjdcyJ/HlK7n7gMtIY/PvJQIRNKz95+QgSk7lS/uQz8LjXRTF2TEZV7MaYY
	gLnuqbkg85h2S1GSocozgjKxY0LyCao8mMGU7Rq9pPyHAc7f+kBu+ANONNQ==
X-Gm-Gg: AYBFou1RqSjdxNg+TEX38UQ8V80u7YfoZbY39P4kaNTk8yP0/Q/BNlBK6klGzgDzwdy
	nEzQGPYdayGuIy56vrptNFx0AqRllYE3WZZK03QEzFjixou2PsYCpffx/SSS/QODxILs/NB75KF
	4+hZJtcvVBqk6lRurchzQJIhT3umUPSE7rVa7+nMjpqnmNPxYvMQZx6/nxxCdpz26MiLXStHn7R
	NyfyC2RkPdBE5KAYrNfB37uzT09clUVFIExLxqqvPtc1xzfJMqsnNOBeNCI5/gmzXVXp/ZUq7A2
	fhopOlXIwHb73KYGLpDmNjkwfhRWFl6HGOY4p3It1IhGavk2o8t40OjbrsDdftB1A/tJLgczB1o
	c1/a3ic9pfOA=
X-Received: by 2002:a05:690c:e250:20b0:873:5c0f:295 with SMTP id
 00721157ae682-892269d3f41mr7600217b3.63.1789575321506; Wed, 16 Sep 2026
 09:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-2-1d3360e21f07@uber.com> <20260915190132.9B2131F008A2@smtp.kernel.org>
In-Reply-To: <20260915190132.9B2131F008A2@smtp.kernel.org>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Wed, 16 Sep 2026 09:15:04 -0700
X-Gm-Features: AcwNN1VMfAW9tyGy3MAW53y0Y_4rMhNKLpGNe0bKvVhbPRWeSPKrItVa4Bps7AI
Message-ID: <CA+w=M=QMz7vMtNwUbObzfQO-6A9Xe-tuUrj-LU6i13UDanOSkA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, all three findings are valid.

I=E2=80=99ll make the global accounting counter atomic, ensure that a
budget-truncated symbol tree does not fill ranges containing omitted
symbols, and use the full stored name length instead of the truncated
u16 namelen when unaccounting allocations.

I=E2=80=99ll include these fixes in v2.
