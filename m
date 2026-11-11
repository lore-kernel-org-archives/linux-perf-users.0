Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368909;
	b=zSw0IiHhYZ3GiZ6q9IlpNyhlQKqGYm4Yg2y4WfKO5LhnyZCqKMRxa9tuFCBEGnaKc9qp
	 a2lKTmu0a0jepyhcGkjyF6ExJNQDDDCb0KfJwNb0gjYCAnzQ4NO/ld/+KZhjIJ+7lZEk5
	 GskgY4hI1pV9/8ZxBPQ3OmLV8RVPY4zA+Xf1dSEkLVVP2ra48HSEzkmZuEwU55lk8iXRe
	 +qgxf8/BBe/PfVtse/H+IBMZRTkY+vHjAc90IlwsLuu0aOCSsxFNrGlLCQAVgGV2+TY26
	 f0U1PdVysHplaGS0ipvidBE17+niwioc/ALgbtrd28Fi69OlTgeUjP8E8oTAaDipBfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v/y7suDvVgoADB0QL8lg5XlhjIEAhIzk+ZSESJ6k8l0=;
	b=USj5V1XWmM+qwDwxcPi39BUQVJB+NmHI3CXfDPHwn1gAQWIjj0IkBioNmYSQ6Z0+upwE
	 VspfsJO+F7FnzWqXtqG5h2/1cw5t2cVlSgqboEUEBHO7cfQFB9AhoPLA7nhFjDsboaIUw
	 HtpD8P3U8VGgWBY+K2nckI9zOZTQPgagDbaYhx/3+Os/aYVxMQzbMlP9IjFMG9fpNspW3
	 Nxv2EGK04zEtjiLGUck+op9PY3yhd2ZkxJi4OoWVZI4gDQN+ZYcVgdtrUE9m4aVtYh66X
	 tjVradTrsG4xlQfj2+4CFmLqkqEtukH382j+wHw2mKNRUeaHGk7jec48ySC8pZAh/LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XSPhMzj1;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17446606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17446606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XSPhMzj1
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36f8cdd30beso4549270eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368908; x=1794973708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/y7suDvVgoADB0QL8lg5XlhjIEAhIzk+ZSESJ6k8l0=;
        b=XSPhMzj1N/9y8/bpzkl5sLlCzVqNwUoQqsk0HFvVYar9UrFh+KFPGYIEFBm/q/xgDX
         ven7846o7WbaTDfxO58tKjxLc59MYz5PrAYJD3SONOJmoAudQigxoic5ElabzO6CY/rw
         ur/dfpmGgB2JY9EeENoBoIDUB0cWTq7fkCGvp1wgrwu0PNRPunwwuoY7FZ4d2m23sdPC
         knUG8FhgTXgQqQcHueaLR1u/nSCw6IDcKXczCwePoWRVBte3JmDxBncPB/IrX3cSB3Ef
         +UyvP5VubjhR68BzG5OcUmB7NAD+BeaBAI2NRowqBdVKtHHyv4i2Z1FDYHkbvBEfK6Nr
         Bb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368908; x=1794973708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/y7suDvVgoADB0QL8lg5XlhjIEAhIzk+ZSESJ6k8l0=;
        b=hVFM2JhwstCEUfHe77e03l/NthNl6lD2fCNRhMPGV5SWBSB8KQZ+nxUUlDUhnmjx8G
         9m1gcv9PFolXh4VNZFgCkqqs/uBKeLBHArbYoqlAAl9JmAiAN6KU7/GBuh1KU6Lew6Zk
         R5pwhKtfXYgKZWsabxo04/+4ntm2fvPQ2p6qczS5cBZywaM7YYFYvGklqFFXrz597Bvi
         6FUkDmFNjAAtbln6NLduYdqeB2LqGVkCFZMX1dnLshAap8hUBP5Wj/J4mtcitD3WTJKL
         6c+VSrh2Q3GlMryAZd8qjfDtjrltKnFMRdWg7yrR3jxREV2bl33f4Y++a/05p6aZyjyT
         OnLQ==
X-Gm-Message-State: APuU4Z9HzUXOOIx+bP+glOmzS1pgzJvev6R/8TK2jvN07M0vS3xZWGBq
	c4V4XclPGjhLKNWgojq7f5F/zcN6OaoymlIFtQ35VpsxEzAnVdUR1lFp0RRkEjeV2CY=
X-Gm-Gg: AYBFou3du2StWUSeN2+Pz9mzu6CmCAIb/ry6ojq6RrTSVAQmk3M85uU2K8BXdRpDCUP
	jV6xFp8mIyr8IPOkPnAq+52MtTRavpjbZUvnJApuPkfZgaewC7g6U4IloxsGqeQKZY1gkG17UWX
	p5ldJKUCu8++2lf1kytC3YzYRgVA4VvUv+OIaLzsALQbKO+bATfeqakwGxoBgU0+Hck5LHtLuBn
	ljOZvvmgbx89ff7Boo0z//Pfg3ucIEW7IU80m+thvwN64eV+ARekquol5xHKsG73Y2tSR9HiQv8
	cVrHAYn5430cci037jwfweAc5GHMznQRBOujy5p6nO6fqf3MQRlHF6g+0tUECw0viIEGtqRAnR0
	9HTyxeWCwfG7sVJ4lsIL2DTU3LKM3Yr7p/OruC67NmiGgLWpmN0YaitbED7WA6mS2JtfUYFfDbY
	RyXhMeUOq6goPxWXYcQRuLR2OxSsD7eRJ0yR7NtrNtxGtFotZonehBK/UexQy/9augL4BH9e1sN
	F/OKplIbnzym9YSj/CXEM5g1QNigFJSBMyEjUOI2DqAHw+JLT8X3Ev3ulA9rQqGpOsXZDpX2PHO
	yDWcDklDGpsgfDcUbCLgOJ6adi+sHcTcEI2MyX94zSXyIXIR/xNl0ZDC3rude2MnqM5kOxzQQDA
	0q/mSCAVA
X-Received: by 2002:a05:693c:42d3:b0:36a:54a0:6b4c with SMTP id 5a478bee46e88-37686757ce7mr1520139eec.25.1794368907897;
        Tue, 10 Nov 2026 19:48:27 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11606489eec.15.2026.11.10.19.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:48:27 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: TAKANO Mitsuhiro <takano32@gmail.com>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf evsel: Skip group members without fds when walking a group
Date: Wed, 11 Nov 2026 11:48:22 +0800
Message-ID: <20261111034823.3277970-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179436443230.1969401.16257974217570748224@gmail.com>
References: <20261023085629.1694941-1-takano32@gmail.com> <179277266830.1885600.10381796857085073613@gmail.com> <20261110030832.3060145-1-hang.zhengyang1010@gmail.com> <179436443230.1969401.16257974217570748224@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 02:33:52 +0000, TAKANO Mitsuhiro wrote:
> Would you post it as a follow-up on top of this one?

Sure, I'll send it as a separate patch on top of yours.

Thanks,
Hang
