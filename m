Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2719322DA6
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602556; cv=none; b=rgppW/Huw4gGEDi8h4935JFeU8+q2JcCFl8NylPSJ+xmmP3ixq5+e7TQtR1WcDESwF/Z4dKpSErQYcHbhu8gixTDCR/xaQeHPqdk59tAX53xPIelFopgM+OJ6XqJIfYjg81Ycp3WdGL/QlVardHuY2eaQIz/XvYSCdq5f286b8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602556; c=relaxed/simple;
	bh=ljNmmhgO9RaVR5EfsrA+jtClGqwH4Ncw0+lLHEpMKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv70o3Y8qrUUDvvWfb5Ej+2C5QVFNcoDxgUzti4G6J/IIQPJLP3pvU02Aug/Qd7xtQiUwzhFukJ4Hhdls1FQ+JfktWDGBeCWXAtZdURoMKkuvM6Rqrp01GTwiBq2ZJKAFtlKStE0v0cFNZYtKteY4L6k770lByeq+cCIlrIvtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJBkTHKC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJBkTHKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755602552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdBinzdAYenwJX8OAfplMqIPm3EH+LTM0TGcBywLoj0=;
	b=hJBkTHKC7xxyZ4/aReLPGO6dnGHI0VuzD9ue40LzqzTUCaFa22oEO+Aee5LY4H7avjoocK
	xy4G/qOfFTpBUgzk4wz+fb4Ijnogh/P5EFr5ruyD8aC0fO2nbR9qlcaTvhMt3M93UAZm+W
	VIQn9OPz+nipXbShXDeQqGDr5t1csLY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-X9UDdFmhM8i4lJmDEyZKzA-1; Tue, 19 Aug 2025 07:22:31 -0400
X-MC-Unique: X9UDdFmhM8i4lJmDEyZKzA-1
X-Mimecast-MFC-AGG-ID: X9UDdFmhM8i4lJmDEyZKzA_1755602550
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41bda7bso3158255f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 04:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602550; x=1756207350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdBinzdAYenwJX8OAfplMqIPm3EH+LTM0TGcBywLoj0=;
        b=BswkAccErs2WEpBnFU5milCLbmOeKrjYqacUjeuxFGyIh1HDUDW7P9Sl1f2E+Kj9er
         7Z5l/eznLSaW7l0ohC5W+V87s6IyAb+NmpuUUbpgEXlM3DpE4XYsGSEmRySkLVKZXEM0
         D8qgx7l6YzLZjiqqc/bIJQ0N4wyCr6ZI56AtQ/kLxqDBhqsRcL5q76Bkedw6Cwik3Sfr
         QgbAa9cqcY7X+oHWadgpEWx/0sa5Zds60L5FBgyW2iG37FW+7yV4eKVmmk41wEBo5WZU
         utVTfutaVwYfZOKGLJcbGmPFmSe8BDV6gFoVDkG4Xi7jA2HtDY63cOEOG+UoUEM/5Gc5
         NhHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyWt9R7sWpOcRXfLK6jBaTvzkD4+S3fRBe3c0ISHt8AxINqkmSJnnXMsO4EMl2LaP17bBK9uJA2jzfNK5/y9K/@vger.kernel.org
X-Gm-Message-State: AOJu0YwLl9VN4a0/ooVtym2I0zzNvs/yDYcCYSlu/4WbB+f0KRU5lABu
	DieZRSaxnereq4kIIxNTuDFtAiKEyJcPOgIl8IQux0pYONNXlcuyyFIo9N4YyVrm8Z3eNoBHGj8
	ffOeyaEUbbP63FAETaSqE9GUvponBu6VtTV0tRQ05gMu0uk8f4zXo7PT/NVR5N0EfG68UNyk=
X-Gm-Gg: ASbGncvrdy2JAaUtGlUzo1sbpchPxIcyvaY5Bc5QqhAEpz8ey7wbRhGCfTgI97WNZ24
	D3YnBTdZzqxm0Cirtls7eIRFpAF00TBD6o0fype+kIKo6FsaFR2W4sS4Vpven4Wu75p4RwhSfa7
	wi4BnvjV0H/F4FDuj+RDOZgo0PPkRmozHJIrP+vcKdZsP3CqmBn3/adduRGUvaS7e4OsaamcqZi
	xNo9Sj5DDfPRZhLbTMv5zu+0dfweyB26CMsbpoGYOAGhxjCpiqkguNt6ZV/gznoOF8mhJiPj7wt
	jq5p8xrA6qjwnlzT1ET1zPxFFhN9rJ1e
X-Received: by 2002:a05:6000:2387:b0:3b7:9aff:ef22 with SMTP id ffacd0b85a97d-3c0ecc3206dmr1914968f8f.27.1755602549996;
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv8ySp3Cp9nuKkaFnxvZbN6GvUwPZexJl3kz+HR/Y9XxHDTyVom8LjTJyyFuYXs6XeX/e9Gg==
X-Received: by 2002:a05:6000:2387:b0:3b7:9aff:ef22 with SMTP id ffacd0b85a97d-3c0ecc3206dmr1914938f8f.27.1755602549506;
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a84417sm36364775e9.13.2025.08.19.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:22:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
Message-ID: <20250819072216-mutt-send-email-mst@kernel.org>
References: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
 <20250819063958.833770-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819063958.833770-1-namhyung@kernel.org>

On Mon, Aug 18, 2025 at 11:39:57PM -0700, Namhyung Kim wrote:
> The VHOST_[GS]ET_FEATURES_ARRAY ioctl already took 0x83 and it would
> result in a build error when the vhost uapi header is used for perf tool
> build like below.
> 
>   In file included from trace/beauty/ioctl.c:93:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: In function ‘ioctl__scnprintf_vhost_virtio_cmd’:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: error: initialized field overwritten [-Werror=override-init]
>      36 |         [0x83] = "SET_FORK_FROM_OWNER",
>         |                  ^~~~~~~~~~~~~~~~~~~~~
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: note: (near initialization for ‘vhost_virtio_ioctl_cmds[131]’)
> 
> Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode selection")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Applied, thanks a lot!

> ---
>  include/uapi/linux/vhost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 283348b64af9ac59..c57674a6aa0dbbea 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -260,7 +260,7 @@
>   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
>   *   - Vhost will create vhost workers as kernel threads.
>   */
> -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
>  
>  /**
>   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
> @@ -268,6 +268,6 @@
>   *
>   * @return: An 8-bit value indicating the current thread mode.
>   */
> -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
>  
>  #endif
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog

