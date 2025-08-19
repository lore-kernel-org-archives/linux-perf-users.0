Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA82C11EB
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610899; cv=none; b=Ixrnt4LfybdCnvxWQnp6JBSEnQNcS2qp62hpffALjq09da1X3AKdt6c/WRbFHTaCwS0C1tyIpMdggbkRogyuhgLPfvG+58tqp6qux+uJvBjK/S1aSdyNWPUPRT4VFzUNH3laWnpw0HCR5ySIVNLJFXLvoeS59kjQ/hNKZ5C+GP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610899; c=relaxed/simple;
	bh=45kfBlIx/c2YzCpopNGEzgYrDpvm5CQrUb7RS9hYw5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzeaM/L6eAxiTtgYFD7uu3cQxsDq2gX2nQqcEPx6QyjzReGGA4oPdlMmp/hN0Fxgoqfj6ysS7UAk4mMF3MYh7XsM7kaNIkoq/83Ezdm8NBnMR9bDhk6h9wZCP1Ulk4fzcchf8opieligdmYd/zY+idBXVSWUSYU94dbqXB4NHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTId6T+a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTId6T+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755610897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EujI76cBsDT4aJDRz+24Ho6Ic52R+N90rhwAuXHewjk=;
	b=XTId6T+acdN3hpv9jXPBq63m2l+BTsnhsPfigvwXtAGxIH0LpGEm+1m/eb6hSBm3I7UtKz
	kS78Xmx+ARo6ETuIop2IuLhKnNN2J4VrFYI3+usxbVEBDFElRzF818bWGJUIg/yd9k5YEJ
	YOErgPCLU2nzQ+s58VrJhL0ErdS4koM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-0hXqlr74PUy4RWZTxbyNog-1; Tue, 19 Aug 2025 09:41:35 -0400
X-MC-Unique: 0hXqlr74PUy4RWZTxbyNog-1
X-Mimecast-MFC-AGG-ID: 0hXqlr74PUy4RWZTxbyNog_1755610894
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afca3e429acso524526466b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610894; x=1756215694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EujI76cBsDT4aJDRz+24Ho6Ic52R+N90rhwAuXHewjk=;
        b=rU7UPm9hr12n8Bhuo5KEYUeDZ2wh+YJTp1J7/qO94Su2EGrjd/qNHXWQDImlegozSl
         mmbOr9SywZUDVG4+ptuhCoD8aY4TnE8rWCzQdrozCT/lDou9AcoSM3wxJpbAy2cSgnpJ
         jGCB00rbpENMDdj7vqoG3vM63cvDoJzswfEqD9mx+pcz0zosfskEcyqdRWTK+CLh8McO
         /KXZuavD8Ro3pxar1+issa09gSpGl9caroZdt2TVAcesaWtyicPn6kVP73oMEtbh5s6P
         GopyTi+Xu3JlYKIXxvZMBgeH5yKwq5Nkti7y51nCR3T8uzMQycwyBBrwtHhfVjmpQwuZ
         kCKg==
X-Forwarded-Encrypted: i=1; AJvYcCWzZ1SSgykQJ0wFXnt/kfSceFog+TSjHC4/+4AQnTSdZe7jKRvF2JLkPihd8z0UB0ObgY+ZM6RMalSjNIQbI3Ej@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLkdcIFHCwgsRfyWbzlKyMJN3gYm9UtQ54z9t70sAcNkkP2Mf
	vnymA+a/9bYTRC6NO6gE91TqdRyNbksZbeC6f4WKPT94/RQEnxKAZGjmtQY5QHEDSqdlyLdQZMG
	Lf95IyMzE8pfQn4lR/njdKrQAFWV5OOQ4EAK43v0UOCzZBsiSnu9IorsVQXdsxVme0kWMdPC6rQ
	zX8oxXECNFmWnfrqwGA7GkbFM9BSPWGKcy+7zjskc/h6cnZg==
X-Gm-Gg: ASbGncswLut8jnT2X3D4T20PH2IZ1FxKSzvFzKz68IIc23PMeRv/imvuu45rMqKmF30
	hv/RfqMSr2Mo6SRbunso9/5yZyoGFX4xWj697GLCye3smf7V5vKEI7cukHaKxn+kVLc4yvL1wFu
	D/6pPT5SNlUcUDrOdiafLfYw==
X-Received: by 2002:a17:906:164f:b0:afd:eb4f:d5cc with SMTP id a640c23a62f3a-afdeb4fe8d9mr16481866b.31.1755610894093;
        Tue, 19 Aug 2025 06:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1GVsEmsaG7XrNaXe8wonzWZoX3xXdB8eON+UVwMeu7PAq8S6nacljTSpJPy0fGiNqSMsvj1L05aVdNrtBjig=
X-Received: by 2002:a17:906:164f:b0:afd:eb4f:d5cc with SMTP id
 a640c23a62f3a-afdeb4fe8d9mr16478566b.31.1755610893561; Tue, 19 Aug 2025
 06:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
 <20250819063958.833770-1-namhyung@kernel.org> <20250819072216-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250819072216-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 19 Aug 2025 21:40:57 +0800
X-Gm-Features: Ac12FXwPH4sSIUdUFp_9NFkFDCQTsp7XMFuiZKn4U01cioGDSa8UFneCp5B5QWs
Message-ID: <CAPpAL=xm9sgU=8b4TTYSMBYkdmgxmdx4PXFPGwYe3qkqcCh=3w@mail.gmail.com>
Subject: Re: [PATCH] vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Tue, Aug 19, 2025 at 7:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Aug 18, 2025 at 11:39:57PM -0700, Namhyung Kim wrote:
> > The VHOST_[GS]ET_FEATURES_ARRAY ioctl already took 0x83 and it would
> > result in a build error when the vhost uapi header is used for perf too=
l
> > build like below.
> >
> >   In file included from trace/beauty/ioctl.c:93:
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: I=
n function =E2=80=98ioctl__scnprintf_vhost_virtio_cmd=E2=80=99:
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36=
:18: error: initialized field overwritten [-Werror=3Doverride-init]
> >      36 |         [0x83] =3D "SET_FORK_FROM_OWNER",
> >         |                  ^~~~~~~~~~~~~~~~~~~~~
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36=
:18: note: (near initialization for =E2=80=98vhost_virtio_ioctl_cmds[131]=
=E2=80=99)
> >
> > Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode s=
election")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Applied, thanks a lot!
>
> > ---
> >  include/uapi/linux/vhost.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index 283348b64af9ac59..c57674a6aa0dbbea 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -260,7 +260,7 @@
> >   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
> >   *   - Vhost will create vhost workers as kernel threads.
> >   */
> > -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
> >
> >  /**
> >   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhos=
t device.
> > @@ -268,6 +268,6 @@
> >   *
> >   * @return: An 8-bit value indicating the current thread mode.
> >   */
> > -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> > +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
> >
> >  #endif
> > --
> > 2.51.0.rc1.167.g924127e9c0-goog
>
>

