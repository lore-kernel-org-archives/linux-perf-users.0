Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09EA2BD029
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572215; cv=none; b=HGnaDqPilXjwuM+6+9cmpb44xJAoE3ywN6fd44tqqgSJ0Z4rdsvIq8IeHiQnFFALDIIVx9/zTqr4v1MDsyihqpvUYMXRd5swJvMlAd+rLIcX69sO8aEQ0kkhNKgKg+s3/cqiJE/GVV4ZyIvrM4Prtrn0K5DXxUB/Z0KJw+cqvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572215; c=relaxed/simple;
	bh=vOTsLPHrmR4KWPLCxzIidma6yhGcdhM6/jmIPZ0Y6GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0NcXEVyyshkGA+CtIJMBR6Cs2QgvwwkYFL4KN2Zp5If8SboryChGoiftPWciuD2WKnrGRAlK6BkDEo7OsrTdCo0iiA6CDn5FZ1YILvs/ULr9V/CrTHV/Ci2AAREPAVuakWFOrZkJs8Qc7S72n7FpfjBPM0vI6KfH72Sj/nTMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOSeZ3Z/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOSeZ3Z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755572212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30rtf85COe0Own+57CwCTiuCFuWNx+52rsJaNL6+eGg=;
	b=gOSeZ3Z/ILE9sAufFY/na3pQdkWDx5+IZHUgCFu7Glu3kH9X8PhdfN84fbwqDLMTFBlQ7Y
	dMHKCMyRVoyPnExpT1kekcaRfRHHmogb2TKTL+dm1HgjcNRhgTjTJkQX8GWWpCLGNKKqq3
	zMjWMcnEefZragmFIcfVlnuhfqR2UHI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-VM3Am_zGNbyFPfeza445Sw-1; Mon, 18 Aug 2025 22:56:51 -0400
X-MC-Unique: VM3Am_zGNbyFPfeza445Sw-1
X-Mimecast-MFC-AGG-ID: VM3Am_zGNbyFPfeza445Sw_1755572210
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47538030bfso459953a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755572210; x=1756177010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30rtf85COe0Own+57CwCTiuCFuWNx+52rsJaNL6+eGg=;
        b=Xjnv9BLQQ1n82X7opL8HEjek6RMbQhhsbfhXcttY65Wzfg2RICcKR5WazrKyjyBB3f
         6Oq8eypugivb2CKxuuyrPkX5URcF1u6AHqh1UOr2jOrVlPFCSKhSoSUuen2SVMni6b9R
         aQK3FBRMKJlJCR7Y5g1xwKojF9XbOpQSpCv7tsr4QYEfkHpyu56mUur9LdFl7AIuEkC5
         YSbTrqQn+hg+WLw4eWg/Zd8sv6Ap7gg5mfsosBrRg37wffPIiyvqDU8d2QwD5pfbGOdb
         yIeDL1ckIR9OFDSJ7PXEeQYSpTMasYKGFd04LlJGsW8nariTG+Zs/onwUitEKoDSfIz8
         X/aw==
X-Forwarded-Encrypted: i=1; AJvYcCXxHeGScXD/F62GqQihPGpFGtIDEEmLIPQlTBAzkN7qq5AdStmlZhJE7w6BiZrZJUk2TmpGz58/hxy1hHqyl3Qg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl93QtyepaIM/Rkh1lpcBRkIuXKc6pT4938GsCmoYGw1yRZElY
	SfY02xLlF3te6R1TENEqS4CY3QsfoDQLoPAKtTjJFzEg5fiD6eBTTFmrEtmKQr5nW1g1nnN/Ki+
	T4ykabTbYkOdn03Rh33PldxKRBSZuocxWnGWf3gUU8ux07SWgPL0vlgKUND+zC2X/H008Kpl+4d
	4n0gztjvJshNQ/leZTLhHytoY6viJod+qnQTvd3Q+DygW92A==
X-Gm-Gg: ASbGncsncpR+BasGvNocYsFyvsNLkZIXK5Gn5Q5evt6yiL9sE664psjZ6AnuL49xpHN
	l5Mh4c/yqClXaAtvfPz4ERCJ+vFDQCmeiZ+JRMprEZ+bkt0wM18xeiDmtxfy+QF480JKvFx35LB
	YhFcJdZrfF96cQJZvPHiyrNb0=
X-Received: by 2002:a05:6a20:6a24:b0:240:750:571 with SMTP id adf61e73a8af0-2430d4c1313mr1346437637.42.1755572209919;
        Mon, 18 Aug 2025 19:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnlIuMdMyqhr/p8CYdMvQzUInme5H88bLRkT2Jl0duOeXAZIWJz9QHEu8m1RFiElzvhplq7z95g+i2y/CkKNc=
X-Received: by 2002:a05:6a20:6a24:b0:240:750:571 with SMTP id
 adf61e73a8af0-2430d4c1313mr1346412637.42.1755572209496; Mon, 18 Aug 2025
 19:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKOLrqklBb9jdSxF@google.com>
In-Reply-To: <aKOLrqklBb9jdSxF@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:56:36 +0800
X-Gm-Features: Ac12FXz4QQ7I_WS0I16x3o7tcM5Be883zhtqEJVTDk_lwuE3fHpjghTmF64HFYE
Message-ID: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
Subject: Re: [BUG] vhost: perf tools build error after syncing vhost.h
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> I was sync'ing perf tools copy of kernel sources to apply recent
> changes.  But there's a build error when it converts vhost ioctl
> commands due to a conflicting slot like below.
>
>   In file included from trace/beauty/ioctl.c:93:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: In =
function =E2=80=98ioctl__scnprintf_vhost_virtio_cmd=E2=80=99:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:1=
8: error: initialized field overwritten [-Werror=3Doverride-init]
>      36 |         [0x83] =3D "SET_FORK_FROM_OWNER",
>         |                  ^~~~~~~~~~~~~~~~~~~~~
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:1=
8: note: (near initialization for =E2=80=98vhost_virtio_ioctl_cmds[131]=E2=
=80=99)
>
> I think the following changes both added entries to 0x83.
>
>   7d9896e9f6d02d8a vhost: Reintroduce kthread API and add mode selection
>   333c515d189657c9 vhost-net: allow configuring extended features
>
> The below patch fixes it for me.
>
> Thanks,
> Namhyung
>
>
> ---8<---
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
>   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost =
device.
> @@ -268,6 +268,6 @@
>   *
>   * @return: An 8-bit value indicating the current thread mode.
>   */
> -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
>
>  #endif
>

Would you want to send a formal patch for this?

Thanks

>

