Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EF3F6C3B
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269578; cv=none; b=rNQql12pzGRyBvXMpDFpLKtGlVefeGfRB7rFnd1q2ffsHq+/LfTgUVXkCBSm4qxqvYmIVntGl9isW9MuFwIq2vBI2UsnoJrcuBFzrIrjAb8zd184pQxBW6mkJ36kOT3WoxgL0cDFEz4UaalQbACyKLDNC6R8wYZpWDuC8mAMVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269578; c=relaxed/simple;
	bh=zEs8zbpBeLmcsirdvDRymDjC6wrZPtFxVOuKr9kvr58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tuzsBs3RAPFYL/uSHoZCfuRWNrfI5wNL/ISzsIfGDreRT9vj587pLtQoP4kP1HNMRTaEDHUTJkJfET1jK5yM3kEaIJG5ltIwybHL7rExzvpWKaEx7XBEKTNqqPZ0tH7PzZAnS5ftxOEwWHZmXXS1jG1zVJqI9loBR5X89MYHFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtgGVa+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtgGVa+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC26D1F00893;
	Thu, 24 Sep 2026 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269576;
	bh=s66xJUKGJMbnIb6sxuSqk1hEGGD2I0Q3Rwon0BvMyBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtgGVa+/hWLAO+WUR/VTty1Xz3tG4jFvwogPkk7XSPS9owGXSYj3db/54QBSjR4oE
	 24KMa/fNcPAB9bQyCGnUGb4ZcqqeXpEFGxrg2KdeNOW14Sojoaq6dz4HU6/+2LuAtu
	 STwlgFuYAW9JfT6FHt6Tw9jiV/0ZvXSm8d0DQ00cJazH3L+ZrJIB4oK3bngntfFhEj
	 mZsZNsPwTbt0QTHm06tyiw2OfWeFYJojFjsj+4Oc0iOiRtqPxl7gdLFVRilQexyijm
	 KbPk2T3D+t02JfOJPVgsYEjqtqDpOCkzOzczI+3pjLqpPNf/tTH1gXd5a09rKIUZRm
	 yM7HQGG9C0R8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/26] perf vendor events intel: Update meteorlake
 events from 1.22 to 1.23
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-15-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:06:16 +0000
Message-Id: <20260924170616.AC26D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/9020a281323a0fb26ee464b3be6e294=
6573cb963
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D14

