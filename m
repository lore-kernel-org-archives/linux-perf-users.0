Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D51DF260
	for <linux-perf-users@vger.kernel.org>; Sat, 24 May 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084303; cv=none; b=K3bWymj9NSKomMHvrGjAcZ9NvWrv2f/o30b4cxfeoyM9MpTK5ohd4y3fIqgEhsElzaIiJvHbJDSZDNVsKkuHfNpR5exAVFKBQBcr+kG0O+SmUKgaaU+jH4aysOoWL5Q6+ULlTAdRC3QTj/SYNxwyEswMP/mizk2qS1Eo3IqDun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084303; c=relaxed/simple;
	bh=Q12FylRBeL663OoZ9YGf5lMA2yPzt4+m/Ww+fftkKwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW9EqaUWBpCGhdHEmbgcvfRGXVXzrAxZ/BWGOtvk6wtJ6772/12RrAe4JMVHnT+qXM5TCcLPHpV8VF3J5VsmaLs11usq518p1kRKOhtEd6k8/n6pAQquuTyOc/En2QEQo3CqxaGlFKjCRJDTlCDGTEgB3SMIveHSCigGyAr1tCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4rYuLEB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4rYuLEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748084300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SK6lTrLghVp8Tcty26pMJozCMpWvjbgpAsSbPEUlhNQ=;
	b=M4rYuLEBmgTI8TcX4hRPklamTLyg1At3ZNJbHOAI/1OkI24CqELwk9uoF/Jw1mIGNyNXx4
	ojkGRhW8BVERo7oTPwKs/Ah0pf94z5ke+JFv9ttQTBuaE07ONba4dBr3rrPsicDZB85WMY
	W8Zi/OGk1X1NWoXVBZ6zZ2FYPO4sjxs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-RawaEDL_M-C_myUhsAxCWA-1; Sat, 24 May 2025 06:58:18 -0400
X-MC-Unique: RawaEDL_M-C_myUhsAxCWA-1
X-Mimecast-MFC-AGG-ID: RawaEDL_M-C_myUhsAxCWA_1748084297
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso826931f8f.0
        for <linux-perf-users@vger.kernel.org>; Sat, 24 May 2025 03:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748084297; x=1748689097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK6lTrLghVp8Tcty26pMJozCMpWvjbgpAsSbPEUlhNQ=;
        b=Y/y69+en5fYeVLv+lL91cgo1rhScNHVJiLIdL1ogtjZ+Qrrwmxux+QvFTKBw2+H0jH
         5Z+7S+xUBmtKV5FAf8GTTjshJ5qBT6fZALK2oq58R8ESlpNfZ8uI0aPMLdH7UwDuuv6L
         OU+ORZw0oXf7+ONBp68ylbWrUihbk87WDK9XnYsfk3ttfCGPs9px/ityGqezXBJQbidZ
         x+1d94vfXGdVwA1w34FWDveZzcD8oN2ZbrZF+7H0PTAQpXmUShGe+rLiXC8uck4J81XZ
         WhiDdO0g1BVmmu1zImqBItyd6Tkv8HZnvMf2caWq62J54C2nmjz+G20r3zcw4Rn4wycU
         1k1A==
X-Forwarded-Encrypted: i=1; AJvYcCV1vqItNNzL+ax6eV7YyRVRWorox2ivgeU4E5RPZwbgMOu11PNBl/Pqrf7CcKONDrNYAvkF/cC1KVbTh/RG4TCn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1M+KaCylhPsZtFISxoKRq55xCC2hjxxtX6MThmcD/xZdOhLNQ
	+HSZyyl/NJFUmTU/Q77oZOwNmZQS5l6bqfZ29mj+dHYm1OSJ8/0kgrz6iImDQGUbYHZ33k1RUI2
	tO0FpvzvZw38CV4Ti/DmDcUMvpOfKtGl6eCK7UQ4rwBqwsjm1JNGn19cf6ad/uDEY6f3feOw=
X-Gm-Gg: ASbGnctMB+Ikj+L/0/JjK531t+874rqsmfEI8LGjbIE+pHUVqo0CFZjzLp94yoIU6uf
	8t+MxcofrORyREvP2nOfUL+lNBFjA9mCeJgjuYf4iIJUgU6SQixBvvcno99Vldq5Pgr+Fb6qO3A
	yAm34SGmz+ebHA/d9s8+0f/hlEE1frQFXbQg+uvmr54TctyhuwdfBHZL0NIe3q9f9HmDGMVeN48
	goe0v8WaeSh2SBrzy7311yCNXkyVM/bt7Fg+KnzijEylXywvqngOWGFYJuy3y5ACObRq7fX3NS7
	hnJZ0Q==
X-Received: by 2002:a05:6000:2289:b0:3a3:7bad:2b95 with SMTP id ffacd0b85a97d-3a4ca756cc2mr1908651f8f.29.1748084296978;
        Sat, 24 May 2025 03:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOTLaWTmBRxNpW25Igp3sD+EItSM6UN1YCba+6ZKtRV9AV6RTZLoAbkr29tYUl1NFH9wZKDw==
X-Received: by 2002:a05:6000:2289:b0:3a3:7bad:2b95 with SMTP id ffacd0b85a97d-3a4ca756cc2mr1908626f8f.29.1748084296586;
        Sat, 24 May 2025 03:58:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8896dsm29238227f8f.73.2025.05.24.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 03:58:15 -0700 (PDT)
Date: Sat, 24 May 2025 06:58:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/7] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <20250524065806-mutt-send-email-mst@kernel.org>
References: <20250519214126.1652491-1-acme@kernel.org>
 <20250519214126.1652491-2-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519214126.1652491-2-acme@kernel.org>

On Mon, May 19, 2025 at 06:41:20PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes in:
> 
>   a940e0a685575424 ("vhost: fix VHOST_*_OWNER documentation")
> 
> That just changed lines in comments
> 
> This addresses this perf build warning:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
> 
> Please see tools/include/uapi/README for further details.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Link: https://lore.kernel.org/r/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/perf/trace/beauty/include/uapi/linux/vhost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> index b95dd84eef2db231..d4b3e2ae1314d1fc 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> @@ -28,10 +28,10 @@
>  
>  /* Set current process as the (exclusive) owner of this file descriptor.  This
>   * must be called before any other vhost command.  Further calls to
> - * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
> + * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
>  #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
>  /* Give up ownership, and reset the device to default values.
> - * Allows subsequent call to VHOST_OWNER_SET to succeed. */
> + * Allows subsequent call to VHOST_SET_OWNER to succeed. */
>  #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
>  
>  /* Set up/modify memory layout */
> -- 
> 2.49.0

