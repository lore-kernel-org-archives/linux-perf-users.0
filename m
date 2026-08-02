Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C84366816;
	Sun,  2 Aug 2026 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659879; cv=none; b=RHPANYX5xza1QPRWwgRqcy6sRQ/fA5mEPAoW8rIKA1TBFuQEJ1TpQEOdzMERyCpGoez3ONnAR61x8znEBXhw3D/DVXk5sAO+NdBPRHI3Cs/C7IvyzvZi484Cn7Bbc4CxP9EhN2EOatgOzXftyQrYfLlIfTHBYhgCJRdHPXq4pLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659879; c=relaxed/simple;
	bh=FnUxLtXSpHUMqEW6SaT89VMM+Bn6wgHnTbnS7eViyew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwYfN0pmKYaHs7DZBdlvZYbpX/m6Jp/LfAjRbufS0yy06h21yph305+1qIYfFWoQrZNK0rRygC8b38BEnM7gYLV1i75RnSjMZROT/Q6hKneXjbsDsTutNjbYKluH5Rbi7XZU8jNtLzV4K3VCZfAFnWBJS4hIQ0Yvl4TfQejBBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=NJJV/QJT; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="NJJV/QJT"
Received: by dvalin.narfation.org (Postfix) id 9A37C1FD24;
	Sun, 02 Aug 2026 08:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785659871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+u8I2RtRcFQuUqOJ9eCWDbJcJVfd7/BGQvMnQ8KdLWg=;
	b=NJJV/QJToCJYEWyRPwg2KObV7uCZDBNAjwr3dd+f5KJ+KNMLrsbG8wXUkKq5MbqH1NS4q4
	g2hJLyJ8i5L94rDf6BvnpnVsQittdLuH9dUegGhSJiEfbsoBV1STD8qbgXvUlTQz5EyRr+
	ywOnhslBusdRRJCuH0FsPfxYNAm7OW4=
From: Sven Eckelmann <sven@narfation.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, David Lee <david.lee@trailofbits.com>
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix mmap replacement ring lifetime race
Date: Sun, 02 Aug 2026 10:37:49 +0200
Message-ID: <6568295.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <20260731120401.558858-1-david.lee@trailofbits.com>
References: <20260731120401.558858-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5397264.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5397264.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] perf: Fix mmap replacement ring lifetime race
Date: Sun, 02 Aug 2026 10:37:49 +0200
Message-ID: <6568295.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <20260731120401.558858-1-david.lee@trailofbits.com>
References: <20260731120401.558858-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 14:04:01 CEST David Lee wrote:
> Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
> Bug found and triaged by OpenAI Security Research and 
> validated by Trail of Bits.
> 
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

1. weird text (advertisement) + newlines in the tags section which shouldn't be there
   https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
   (and all these tag/format related sections below)

2. author didn't sign off the patch (see below)

3. odd unrelated Signed-off-by without any obvious connection to 
   the patch

   - I actually would guess that Kyle Zeng <kylebot@openai.com> is the author 
     and David Lee removed its authorship (From: ) before sending the patch.
     But in its current form, David is claiming to be the author. And even
     when it is the case, David must still add the the non-Author SoB at the
     end.

Regards,
	Sven
--nextPart5397264.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam8B3QAKCRBND3cr0xT1
y1kUAP44u4nFevVE+ytoinNj3guJOsNQ2Ml4KWswiMhRy1RLPgD+N6z5lCVRZ/pA
5HRD/R3PcjvtztBGDD2vkrnNGbzfzwE=
=XpHg
-----END PGP SIGNATURE-----

--nextPart5397264.31r3eYUQgx--



