Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C31759E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849143; cv=none; b=DYWTjIBHMtlJD85MKXF//EgJ0sgSVPsRzKCo49q4b08tnWVQ4tZf7xWoedBDzgYMSobG9U+JGhu1iFlnVbCqf9zC/QO2KVXC9TiEMVbWCbDxsNQpcXrQUofELWE/ZUF5QeCLpvoVMjpNm72C+OUJgPWI1bbvbv4laeP5Ii6lX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849143; c=relaxed/simple;
	bh=S0tSkli8JleHY8iE9O2afY6bV3mjLC/eVHPCMEho8Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvcPf9kGnrtmTxueJHKabVGolhBwaHdnnWN1qoWVavqJaHdpyzfXo0ud6rRjMOXWwOfWCFoYs9D+Aq2qpnrnwjbw1bGELV0ck06KmjxLSiOXXrb/8JbxzvCmluheToEJ9HHPj2/NV1NENc0pTyUrXK/Jt0fTRnK9M+w4aCws0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U5YRkVIs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5YRkVIs"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56fc155b646so2461258a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712849138; x=1713453938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=U5YRkVIsfjsdxYrqviqFldW3aGgJpxI95Xx9WtuZtRE4oGNUou/5vryJRC9Fm9mbWI
         0oW0BHPWPWBNjOdKKZtlJlPuSTA7JCxqdpogQMFdoBWF1OD3kPk3rs7hdHqbvgvZDg0g
         FPiIFMNvhw/PbASOX8xkWBMy8iKmqHbZbXdnniQgC1etonGUdgwPRRGtUD4z+eu6vlgb
         Hnq5Ee+6VznM1khG44NboOAIt8kYqj5Q2zDb+onyXfL4pNnVpUZMlB7sfzDCSNFLZ1Ss
         C8s8Fb2FJ1eVCLip9agNb+b1Vd0rUZFWc6akd2nrOheBpdsw0oUWp/Fy5ElLUlEqV/k0
         LcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849138; x=1713453938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=ejh3u5gxi8nw6CA8UaskNxZgWRRaMO2mC6B4uQwQoUL5ErLDoW5F5jpHnhICklOYEJ
         A+zSOup8ZXyYsZ0cM4MKZHz1GYyAoKQXY/KmDZqWELePYE8z0D1HKAFdJKslvg04SEH1
         ucomeq2x7168VLJeph3MsUzFa/5YHQGsQerLEZFtZ2lvXhh60+0tvot+iKvUz/4xmaZw
         lXdmTOY2oZCGJZycQm1qalgNA2JdOv2Tmaqqnis39/gOD/cQgYmEnlso636ZGqhubwEM
         Srf0oCNJpjR+/rRKqFZJXtBkszOgEkOwV8GMChyRb2vjPDSMX54wIISG2zhoB+Id3v6u
         lhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQu4Z3V3v2qW4v/iVXON1eBTfh4O19/GltkbNDXLNy9SZF+8JdKURCWLG9lqZmrk7m91xat90B6HcK1Ww52e1PPv51uf2W5qlaUAP0PSCiYQ==
X-Gm-Message-State: AOJu0YxOrxy56qGTcstjUZ2gwwE6aDgEDGOBXeWF/jGX1ea+yaumGlhb
	mt8oYd+QI2dbGgVid6r40YX3yBICQwLGTkN5irvpLjEaXhEM108G8z8v7O0L6EM=
X-Google-Smtp-Source: AGHT+IEEewk7llSPmgrxe/7mA2rySV/OUDonUpYE2d0l2M0z39pI2HKiyjdOd8AbAw/PCbmxmW//Bg==
X-Received: by 2002:a17:906:4f06:b0:a52:3d1:6769 with SMTP id t6-20020a1709064f0600b00a5203d16769mr44591eju.14.1712849137563;
        Thu, 11 Apr 2024 08:25:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906350300b00a522c69f28asm225076eja.216.2024.04.11.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:25:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:25:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	speakup@linux-speakup.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-afs@lists.infradead.org, ecryptfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-arch@vger.kernel.org,
	io-uring@vger.kernel.org, cocci@inria.fr,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] treewide: Fix common grammar mistake "the the"
Message-ID: <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
References: <20240411150437.496153-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411150437.496153-4-thorsten.blum@toblux.com>

On Thu, Apr 11, 2024 at 05:04:40PM +0200, Thorsten Blum wrote:
> Use `find . -type f -exec sed -i 's/\<the the\>/the/g' {} +` to find all
> occurrences of "the the" and replace them with a single "the".
> 
> Changes only comments and documentation - no code changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---

It's tricky to know which tree a patch like this would go through.  We
used to have a trivial tree for this stuff but I guess that didn't work.
It's possible that it could go through linux-doc, but probably it has to
go as a set of patches through each of the trees in the CC list.

regards,
dan carpenter

