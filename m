Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4990342CBA
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621810; cv=none; b=nmjjgI1AeRfbIERlGXgKBActjSLlLgcrjGl64194G15abOj5myFWzYNnD3HbEPNu1zh6yQh+vWAeL6Yra+zVvRKoU6mwPQKWXdt4iitlBdQTdop0yWon3UcsE32oUtnSZSwRtVcQm8nlqV0mOcoKco9xsLWqts8l5XGCXqO8kzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621810; c=relaxed/simple;
	bh=5P1mGm42pBHyF7Rcn6sfL8mB8A+RsZMeGIm/L6S20xI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cw2zfDrbmEjew0ruDtvjtqzF22W+QdlWFIw3w/NDNgy5faXkIuXZp6H1TgSeiNlwLdg1olFFHQhCnZaH1DMqhEjCD7zokj1+o02WAzXYQsJO58Bam6RejMxGaIIS/JL07AKe39KLvcGpRYr92E8t7p1jEg+eBCDFdkY+K03Yq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e11sK6q6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e11sK6q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A1A1F000FF;
	Thu, 17 Sep 2026 05:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621809;
	bh=5P1mGm42pBHyF7Rcn6sfL8mB8A+RsZMeGIm/L6S20xI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e11sK6q6Wh/BJ81lM5OsexNIRgeGJYNbk2LGZXWPiVcWZBte+KeicgbdOI5W+ewFi
	 FmCm++gzyvliM8gcss7IOix+JS28EoP26eWtyiUxQCjI0XkyK747Rix+bhmp/AljkR
	 oRaJa1sBkuTPgyH2YNcwnkS+NyPyIe71piZTpoUj9zrfKhd4h8RRh+LD6QMt5pGxvj
	 98VAx96oOFBg1up2mm07zosA5rUq/zXCU8IbQd90jsBdpjCwCS/TcsQx2ZII4k1qYs
	 i3tEl12NfGuLq/DB4W00BbTH/t/VbzhaBvsm9RDMVuj6x9636ODKWiDdNe9/b2CxV1
	 5VIoEn7DLPgyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] perf Documentation: Add tip for hybrid event
 merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-5-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:10:08 +0000
Message-Id: <20260917051009.20A1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add informative text outlining the IPC imbalances associated with
> merging cross-hybrid core events like cycles.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D4

