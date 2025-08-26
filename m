Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915F2E7F32
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Aug 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193940; cv=none; b=PK9mXIr24z1XPq41GL9ClRklnSsloTVAqrdT+5aNmtUSfUqIkQ+KVmeu+yS567/dwUJ2A8rVMJo7NCfPJdv1wz44IOMNeVwIV5DaxaZsuCRl0IvSDg0POuiGPo0pv5nMWkmjWCBrlzmObqyewFW+Ia4vd0325ofgKMifaQG6zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193940; c=relaxed/simple;
	bh=uP5dMqsHSqXNlw+qX5Xqd1i4XVlTxybaVEVYi61d/5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/Q15mLTgWVmTW4fLxCu8szaNxCmUDcedWcwMyiRdDWTAWNVtVuj0epQEfezBIolAIET8q6HjJU26zqhbU37GEpyKA8s/P5sEaW4CO/+KIyWpIUBzp7TItZwdABVllsvtfWd5yze1Ge8CFtQGzPReYbczI/LIwyWiYW0DGsejXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEh5DK/Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEh5DK/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756193937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/d6oLABXMDTE73AAJmn9nTIS3+npYIzihKgU/wI/Iwk=;
	b=QEh5DK/YDwMy2tOVAV6/5NboS7c7jZPGl/GZzadZGmJ6CIWPMXdAGM6m9ksToTnzF6x0G+
	a6UDA7hYGTeLWCPplfct8zNXWeu4uWGh3/hUHY3OmwubwUk2nHec3efpTNgZNiy44W8fQ5
	vIrFKjP7VVI/KRiQ+KKU60OGLweFB4I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-ToRPY8f7O4-ekBVg__m1Vw-1; Tue, 26 Aug 2025 03:38:54 -0400
X-MC-Unique: ToRPY8f7O4-ekBVg__m1Vw-1
X-Mimecast-MFC-AGG-ID: ToRPY8f7O4-ekBVg__m1Vw_1756193932
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c8bc2914a9so1013726f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Aug 2025 00:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193932; x=1756798732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d6oLABXMDTE73AAJmn9nTIS3+npYIzihKgU/wI/Iwk=;
        b=btsghj9I3/Bu+h3pZsxiZLthlSkHovsyl/LSguq+Lk8/CELHzkiP2f7WQet8txamkn
         OaBt+TICxZ7l7PBVOJFSjqRFNjxFMVTgrzMOCLAhkqujslfwfhADFtzSnv68zkIpRO3s
         1OEXBYBgbrVK22bAasDTA1NeTPR9vkbUZUSEcrAXN/yjnkusrAYA56OmJ4kABTU7H1+M
         Abneh2r/MIq7npz4NvzowUrr6wQ6SMDtTQCbpBNwr3Pa59HGP68EBAyFARrrH4fRUM7m
         MYJq/R/9c2fYlUT4YE+L9VZe+apfPR+q25wPIB0oxm6VzypyFAVES6uS3p7xbLtq0cki
         ZYaA==
X-Forwarded-Encrypted: i=1; AJvYcCV0RxtTXoRMC5qcAyLU2GCaaAbYhS/yc+zual+dLimf2aYNxkp1Gg+hlC8vff3bH5JX6paVOj/Z/GHX/9MrmkIz@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNfJlrQA4f6fyABXQBxWELta5aWgV8pkFHO9bzrepfheRlkTO
	G6l+A6hNwmpCtMQt4ckYNVltZNC6Zc0K55aVgv3M/e6C7nUEP7unrWxMJ0tbOrx0cQIDcMBlGr8
	nvqkKlyLnlnZdJmY3SLq/Bxo0X2HYEkcEsEEZSyijm3LfpkDReLRdCznsfGbKkUirM4X2CQU=
X-Gm-Gg: ASbGncul3nGMAxKlnCZcQugAtdQk+enZcMj749Pr5WcUvYYEX+wiEpNJAips5CjbnAe
	vdjcJAEyrxD8nUU0PS7j4Fs68doFDyXoZ6M8RWTbCFrs4Vmen8xsqF3n+mIfKILbMAQb2gGu4Lg
	bAG588MuuLsq32hfpDnvh/nmOZ1ktDiTZE4i9WBMpcBCQ1zQ3bIDXR+RfHfucsaXe2PKDhJVXpE
	iEBjc3iDqOL/XYou5vLCO7roc73oABroOClhflWuP3Okp+I/ZPtQ4f9wA9/hl7rFgL1wZwP92SY
	0NkRuRlkO3hWjg9c+f+TscNnAa/XKWk=
X-Received: by 2002:a5d:5d81:0:b0:3b8:893f:a185 with SMTP id ffacd0b85a97d-3c5dce05cc8mr11272226f8f.53.1756193931854;
        Tue, 26 Aug 2025 00:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHe+NtzZIdZcDMX+QmPMWtx5hDKS6iQR+ufYxm1cVDTFyfIzaA+q1XTB2lol3XvRHtPrWxGw==
X-Received: by 2002:a5d:5d81:0:b0:3b8:893f:a185 with SMTP id ffacd0b85a97d-3c5dce05cc8mr11272202f8f.53.1756193931395;
        Tue, 26 Aug 2025 00:38:51 -0700 (PDT)
Received: from redhat.com ([185.128.27.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6133d9f1sm66813785e9.14.2025.08.26.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:38:50 -0700 (PDT)
Date: Tue, 26 Aug 2025 03:38:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 11/11] tools headers: Sync uapi/linux/vhost.h with the
 kernel source
Message-ID: <20250826033710-mutt-send-email-mst@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
 <20250825215904.2594216-12-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825215904.2594216-12-namhyung@kernel.org>

On Mon, Aug 25, 2025 at 02:59:03PM -0700, Namhyung Kim wrote:
> To pick up the changes in this cset:
> 
>   7d9896e9f6d02d8a vhost: Reintroduce kthread API and add mode selection
>   333c515d189657c9 vhost-net: allow configuring extended features
> 
> This addresses these perf build warnings:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
> 
> Please see tools/include/uapi/README for further details.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Should I queue it?

> ---
> * This is on top of the fix below:
>   https://lore.kernel.org/r/20250819063958.833770-1-namhyung@kernel.org
> 
>  .../trace/beauty/include/uapi/linux/vhost.h   | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> index d4b3e2ae1314d1fc..c57674a6aa0dbbea 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
> @@ -235,4 +235,39 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/* Extended features manipulation */
> +#define VHOST_GET_FEATURES_ARRAY _IOR(VHOST_VIRTIO, 0x83, \
> +				       struct vhost_features_array)
> +#define VHOST_SET_FEATURES_ARRAY _IOW(VHOST_VIRTIO, 0x83, \
> +				       struct vhost_features_array)
> +
> +/* fork_owner values for vhost */
> +#define VHOST_FORK_OWNER_KTHREAD 0
> +#define VHOST_FORK_OWNER_TASK 1
> +
> +/**
> + * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost device,
> + * This ioctl must called before VHOST_SET_OWNER.
> + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
> + *
> + * @param fork_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When fork_owner is set to VHOST_FORK_OWNER_TASK(default value):
> + *   - Vhost will create vhost worker as tasks forked from the owner,
> + *     inheriting all of the owner's attributes.
> + *
> + * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
> + *   - Vhost will create vhost workers as kernel threads.
> + */
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
> +
> +/**
> + * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
> + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
> + *
> + * @return: An 8-bit value indicating the current thread mode.
> + */
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
> +
>  #endif
> -- 
> 2.51.0.261.g7ce5a0a67e-goog

