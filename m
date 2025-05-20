Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FB25C711
	for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725616; cv=none; b=URM4vhHk0U57lyTtxEjmKAcufxG3qRN4KAfOdGWvl6ldoACbdej5T0TeWY0f5F7kbqotUmO360724dp0/qSslDV6zLpHosk+NPyh1NrsIgvybGyPnPXU4LReGZh93IcrDbT9C6s1QqiQoQNdan0bcgXRaDlLCQgCRqPLqD+ykBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725616; c=relaxed/simple;
	bh=cP7Qsu978JdO14VIy+ZgrNiEsOq8tQhEus1xNAKU9xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOzi+BoEPKFQU0JR5sTu9ydEiQdaITRRaM02JSjuoUC2dmtm+iU8NmSwjGLVuE250TqhPkEZTVB6MCRSJ4tp8ORtjx+wYvgjsndrpJbpNkulkKij6oz+21oYB8KVOgtT2eC7k7oflo8aC9yx3A2mXo6G6ABT4a0rtYsYdMM2xJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVesLqYE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVesLqYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747725613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fQTn3idRl0VQlk8k3SIRDqs4SeWLMUWz5azl60Juisk=;
	b=LVesLqYEhbqdIvt320cxRe6JPcjcNZ2lAdLzo1vJSjDKa/i+Y3wUmRwIy6qtAZWxu/f7z2
	g0vdjTpInYvP+gt+8ZtIC8SWtJOmVPsQXpK1J9Cz1CIYXMLqwD1Xmkd+7QTV0c4tvCK3gc
	ZiBk0gGsPgMZFg/UGvYuNgbr+OBGcbo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-bu9Zh-zxPB-1ipqmwqXXKA-1; Tue, 20 May 2025 03:20:12 -0400
X-MC-Unique: bu9Zh-zxPB-1ipqmwqXXKA-1
X-Mimecast-MFC-AGG-ID: bu9Zh-zxPB-1ipqmwqXXKA_1747725611
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a1f6c5f4f2so2003622f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 00:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747725611; x=1748330411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQTn3idRl0VQlk8k3SIRDqs4SeWLMUWz5azl60Juisk=;
        b=iTi/xkrzvIRIGd9P8sKBbrUgcFYbQpUOysP/zJXXuSvlc1/pbTltPI0UyYwOdhGtj8
         Cx4iXte9hmCnNkPTWCFgwxjB9a8Bn0btxKM2BMfNzByqsgpYNmLyldxiF+rEpkZmJErA
         ZKeV+K2WeoQAV5sugzYu3moikgYI7kmPHr/7M2NHFDAnl0dEt2ss7i8JI41W/j5rPkaE
         axYlBbyZXEhIV2LhxA0OyTR+Zeov2z6TkBxQXr9kXNk9XEUbv5phve7Q3hTLThDz1rkn
         K2hK6IggqcihjnMBvQo1umB/XLJEiQ3iTb8r7iszTSEmGZF0MC1h04IuLQw6eLvOjjdV
         HkLw==
X-Forwarded-Encrypted: i=1; AJvYcCV7+wrP5qvNslXfyM/r6a2ozynOGpqY4syDPkw+k2JKJMyo/FMZS6UlDV7uoHkRHKVMxaNj7fBs4ZmK53H/UZQs@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZTTi1T0RZiNfJpb+PEKxppuVas1IFzGQh6QTjB4u7YHFVU2N
	jrX6bvf5gbh6LhWAK1Ba/uVokb4sBvDuxRhVqafwZPNsTDwsVvdjbXVJCecRqhTjNMWCTcqeDgQ
	GGWU1LmqKTSv0wwSIKuEeThoIZNbml2QVBeUl+ITo3av1kS8zKQ3WnFqV2CsISFqkLRFflfM=
X-Gm-Gg: ASbGncvG1iapwXg4VwSudajKyylkQXZn1WJrNjFCQUjVZcuR2Yn6xLZBv37t501To2y
	qS0Cyu6OK1JmzNV3Cis7F2IblFTooHLAvv6nYBSRTYY66anmpquwGtZS/d9LomNlgMEg79aPIPY
	vzwAKDQ0Kr3cYHTMu1IybO9QKU9hx2jb0HSHsa/m68K4eLJlhxPbA8qGHhCj/2Atmn3RbFIxf7C
	6NtvUs+S5jvyi/skcBjEV06qGPnzZx20VEHFUUxTxeKU8NB35kBfGbmQji5ZiugdiPFRgq80tDU
	kBgeOOD2XNMIp7MhkOeU5fub26r1d8AJdGOXidjdNYEWywXpFk3kt8nqwmSf
X-Received: by 2002:a05:6000:2384:b0:3a1:f684:39a7 with SMTP id ffacd0b85a97d-3a35fde361amr11701755f8f.0.1747725611050;
        Tue, 20 May 2025 00:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMxpZctuxlPRTxO/eDif5ZtBRMhbiuIwkMb+0+eYZU8wMz06n9FB1hYZCoVHkP5hJIZwrLuA==
X-Received: by 2002:a05:6000:2384:b0:3a1:f684:39a7 with SMTP id ffacd0b85a97d-3a35fde361amr11701718f8f.0.1747725610479;
        Tue, 20 May 2025 00:20:10 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef01besm19228605e9.10.2025.05.20.00.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 00:20:09 -0700 (PDT)
Date: Tue, 20 May 2025 09:20:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/7] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <cek234mjuzbh3w4jvwhpx2oundb23tmxjaa2q35ul7bu7todum@hqkjcbnf3fzf>
References: <20250519214126.1652491-1-acme@kernel.org>
 <20250519214126.1652491-2-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250519214126.1652491-2-acme@kernel.org>

On Mon, May 19, 2025 at 06:41:20PM -0300, Arnaldo Carvalho de Melo wrote:
>From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
>To get the changes in:
>
>  a940e0a685575424 ("vhost: fix VHOST_*_OWNER documentation")
>
>That just changed lines in comments
>
>This addresses this perf build warning:
>
>  Warning: Kernel ABI header differences:
>    diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
>
>Please see tools/include/uapi/README for further details.
>
>Cc: Adrian Hunter <adrian.hunter@intel.com>
>Cc: Ian Rogers <irogers@google.com>
>Cc: James Clark <james.clark@linaro.org>
>Cc: Jiri Olsa <jolsa@kernel.org>
>Cc: Kan Liang <kan.liang@linux.intel.com>
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Namhyung Kim <namhyung@kernel.org>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Link: https://lore.kernel.org/r/
>Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>---
> tools/perf/trace/beauty/include/uapi/linux/vhost.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
>index b95dd84eef2db231..d4b3e2ae1314d1fc 100644
>--- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
>+++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
>@@ -28,10 +28,10 @@
>
> /* Set current process as the (exclusive) owner of this file descriptor.  This
>  * must be called before any other vhost command.  Further calls to
>- * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
>+ * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
> #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
> /* Give up ownership, and reset the device to default values.
>- * Allows subsequent call to VHOST_OWNER_SET to succeed. */
>+ * Allows subsequent call to VHOST_SET_OWNER to succeed. */
> #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
>
> /* Set up/modify memory layout */
>-- 
>2.49.0
>

