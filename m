Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699152;
	b=Xooo7I/cTor3uWuN9h+qGcErPmV2OjIHdfS/pQ/b+Xm/wSACqgm4hu3+5LJKic7YDM8F
	 u1aJFjQlOoS5v82NB0Kd6qO4vXEWr6V/k5+BvhdSwzbAs0z3/+NB5Xv6wHFT6G47eYM0C
	 4RKkAHJMRAWeI1jEJ8u3h0wwd+5kqqIJrKw463VJVynt0rq0vhQ/eI0oitSSTZ3ETB2hw
	 y0mx6Cb18GYHg8/yeMN56mByreuc4JAisGo97H+fdDw0gS9m7063h9oVcIk9q01tBK2VZ
	 LQQ3U7dC9pzg2nnSsPhRrwYMVdn8/1f3WkpX+aUgt/IDA4xBHDft2s4fqspwbxliwyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RoCWPzkDrHJr/dgaCUqN2HXVPucGfm6YZCghqMmtLIk=;
	b=RYHb7KZTgrrClTNChN2+IEJFgb/YlMz2U2uGT0vqU6ThK8kh/YoY89hgi4FIe/QRtLNC
	 n5CD9ST4NJXjeBRyclvYrHyjBWcmgFScwyQD0CcdvxL4OzVhUYWwaHcD3hMzpAp66Ep/A
	 ecGUT+LuOzintMwq8aV9mt1viMwh5zfGWat3opYEqbZyyA/FwsMzGIzBGApZdztnJjaGB
	 wXfT2EnXyfEZFjkckz6dzx7m90XWNSOTy7Hv0GaHlItPsZ9TRpu3CdtgvIOIrFV/65DJT
	 xX/fo3dZa40gptSmdXsqAgANksfeFB42O7oUCVMTMuVO9fhNQkM/RAL8VLhrkrooLXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V4lejKYB;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9309606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 19:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9309606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V4lejKYB
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so190141e0c.2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792699150; x=1793303950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RoCWPzkDrHJr/dgaCUqN2HXVPucGfm6YZCghqMmtLIk=;
        b=V4lejKYBxSMGiDWWA0axBwqHGgs0wbJYwTp4ZeJX1alYGcHqK3yuP8GS1u9XorLWMX
         tJhooN6SfCRmOgVaXxdAHweW5GjynhAwet2u1fSk81o4nNfSDa7obUEjo8PgBvJ88WMQ
         96JjoYnGPRUGovzVv4XoBYC4bq31FvnCMOaYyFDDAhPuYsn3ooz01CnkIAGfDVq8elSv
         ozs2JHlZQ85Utr8aWeoCBxPljSvcwlS9+fMXJ64fXyUgNYia8VeuAjcel84OWmaQcjt7
         jBUTC46hb9z2mK5hWmb+iVVPXiLo7SygI8Wj+kQWzsVO7NrYI9QmYSsm5NgIpJcF3qM5
         REig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699150; x=1793303950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoCWPzkDrHJr/dgaCUqN2HXVPucGfm6YZCghqMmtLIk=;
        b=iEDFDtO3n8kJi3knuhB4QYbfOjfnxKbwL+CdigHkN8F1zGV7V8Yd8145ie7Hp+EBCP
         BRke1WmHu6IDiaVjYuYZQoNZKHx2Bt5TPg25xB5N5HU/4qk0M0tgZ22I+RUgYbL80f60
         KWVzCgTRoXL1nyGAq23XjQQqItxbwjt7+iHsAtFsixYOi7d52R7Zc8sZZX/vgMzGTr7g
         JhcEcWX18yPyoWZUpwPHE/guLaQ7ZJr9BxGEx4ojXDWj7ThUTNYVG87ro2xT+halAAeI
         PP5nlwqSU7BiK+rPYzPasEFrIjgEAI8FJMJVRXXfE/vx+UnjoCpWmBIYm/hSrb8BRT2F
         Davw==
X-Forwarded-Encrypted: i=1; AKwUvBzaaxxlQVqRIlEwIPkYQYea38e0mFgescHGGp8wpozRif/ONwPGTsU16qj9hAnxHn6S6gbaZmcJc8lozYrjowMq@vger.kernel.org
X-Gm-Message-State: AFq9FYLQJrlDHql1JhWbVvzXUxUuEGnF18gq1IAG43+u/tgd+ffli9lL
	w+RE7Yfww9th3p2ZjT+CF+yBaiClmoKWrQE+pL5y+GvghbvDqYBGZnzI+eaDFGWr
X-Gm-Gg: AYBFou26M0yT0Jp3ZcCt9SzQM+baHYPMAtwxfHo3XGBp9/3cFfAzdtyHXWL7If4G4GR
	tL9avrPtpv8EqgVOysEVI3fFnoi5maOZSiqWHgiEWjUYDHCKTbmh3Kg7+b2TqgdaMPgHbJmOTnE
	KKeVqRaYOa4oxf6PAyQ8dOxdWdNc5gZlLUeeqaGuxbvt23FpS3ssdHelq2JFzK6XJ4FWuurq+QD
	3PYHLTBeZ5ftoduUKzZcvX+d5H6DfWtZ5Cl2p4HXUuW0zK9eQMufOygwN3a3Pu6XbFoMN3i7MrH
	S9/vmGpY6NREe9t+lLaszvq2ofQYVAjqXPuMjpbjH38Y/6w9C0zv4xCi260I4rS2fW89YZZrUQU
	g20vLXCxOi3J43nVLQFZgpsCIMvj7H1mxGY9cFLUQfxJXXAkQNflg4CGnd43bz9bh3/9jXa3vQj
	TKVG1crC27fVpvMo50zpeXrMSvlwdt+PZlAI5dm6t65hChClYm/BcLCCdZJlkFY8CZRF/QpA8V3
	bDiBUmfeF1s0QvvFdT+62Wkzkv7Y/Kap5jcQHGMOnVnZCAABw==
X-Received: by 2002:a05:6122:616e:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5eaebd9857amr3050579e0c.4.1792699150626;
        Thu, 22 Oct 2026 12:59:10 -0700 (PDT)
Received: from localhost ([2804:388:90c9:8e8c:18e0:eb4e:48f3:8b3e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13ed874asm131464e0c.9.2026.10.22.12.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:59:10 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Thu, 22 Oct 2026 16:59:07 -0300
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev, Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 00/15] perf annotate arm64: Support instruction
 tracking for data type profiling
Message-ID: <atprC5YrmbGu5wKO@localhost>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <atFdpZG-b2JPS1St@google.com>
 <8fdf2566-bbac-4854-8faf-0276af5f936e@huaweicloud.com>
 <atkzKm_TPnhyzgx3@x2>
 <atlO6EJswVvj76rN@google.com>
 <b6c0b7b2-3ffa-4dd6-a4e0-23333e9b7d92@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c0b7b2-3ffa-4dd6-a4e0-23333e9b7d92@huaweicloud.com>

On Thu, Oct 22, 2026 at 09:19:14AM +0800, Tengda Wu wrote:
> 
> 
> On 2026/10/22 7:46, Namhyung Kim wrote:
> > On Wed, Oct 21, 2026 at 06:48:26PM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Fri, Oct 16, 2026 at 09:18:38AM +0800, Tengda Wu wrote:
> >>> On 2026/10/16 7:11, Namhyung Kim wrote:
> >>>>> Please let me know if you have any feedback.
> >>>>
> >>>> Thanks a lot for your work!  Assuming you'll fix the issues from Sashiko
> >>>> in the next version, you can add my:
> >>>>
> >>>> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> >>>>
> >>>
> >>> Yes, I'll address the issues reported by Sashiko and send a v8.
> >>> Most of them are minor, and I'll fix them accordingly (or explain
> >>> in the v8 thread if I think any of them is a false positive).
> >>> I'll carry your Reviewed-by in the next version as agreed.
> >>
> >> I applied the first 5 patches that are sashiko-clean, will push soon to
> >> tmp.perf-tools-next and then to perf-tools next after test building on
> >> my containers.
> > 
> > There is v8 already which should have addressed the concerns.
> > 
> > https://lore.kernel.org/r/cover.1792411435.git.wutengda@huaweicloud.com
> > 
> 
> Yes, applying based on v8 would be better. All Sashiko comments have been
> addressed in v8, so the whole series can be applied and tested as-is.

ok, I'll get it then.

thanks,

- Arnaldo 
