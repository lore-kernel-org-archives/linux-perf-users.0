Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA919CC10
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678283; cv=none; b=L8Qr++qmX9mbLCgX3aZxuVmXQeU+QXzMZFfPr1RvS33YMQxNPDGzeVuFKzFaDZx6x2MkFEYBlKwUwiixjfd9iuSuyFJBbj8T3wSoQEI3Xz/JmdQEQh//WOLEe3aIPiifNa8JaQXAXnLjnEbd3e/mWDoLxY4AtbOZIPaXlA33t8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678283; c=relaxed/simple;
	bh=AHGXjP6/Rtyf1IZE535VfmKpLIVs8d4QpktZBZ/sG+U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q5OcC+933Spn65Idm5YNbdj+KRHO4k6QAVmohUqZeYkb7QOTSM9DJXEiWM5Czk0sgjMC3QsSWfVbyHXi2dGrJalByczpn27HYbBb/y26/Ss2G5foM7olbk9HNeAAMbLVyTgReMyCEXPn1sVUZox5Vth+8gevhfZj/8wvDZWmHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QljTMwWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QljTMwWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE8DC4CEC3;
	Fri, 11 Oct 2024 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728678282;
	bh=AHGXjP6/Rtyf1IZE535VfmKpLIVs8d4QpktZBZ/sG+U=;
	h=Date:From:To:Subject:From;
	b=QljTMwWsxSPLqYlK9FL09SGtuvA2/OLQCfEX+BfTcR2g9XoDIG+2dtH7mGy/qybBu
	 JXQFulF52bVWnVEpXZdTQKqqsoRHltEolBpPU1fYwayFcQqnfmJ/JwZbjPDjBl2EEq
	 it3y0Kykh58FJwJY4vI2CAEqnsK3fRYu4p4Exrqk=
Date: Fri, 11 Oct 2024 16:24:37 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-perf-users@vger.kernel.org
Subject: Migrating from perf.wiki.kernel.org to RTD
Message-ID: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

We are getting rid of all mediawikis and replacing them either with archived
sites, or RTD-style documentation. The perf wiki is one of the last ones to
migrate, and I would like to propose that it is migrated to RTD-style docs.
I've done the initial conversion from MediaWiki for your review:

# Initial conversion

I've done the initial conversion and the preliminary results can be viewed
here:

https://www.kernel.org/doc/projects/perf/

The underlying git repository is here:

https://git.kernel.org/pub/scm/docs/docsko/perf.git/

It actually contains most of the wiki history as well, excluding media.

# What happens next?

There are two ways forward:

1. You can clone that git repository and host it on github. This would allow
   for a quick readthedocs.org integration and allow you to edit the files
   directly via the github interface. This is a very wiki-like workflow and
   would allow you to grant access to the repository to anyone with a github
   account, plus accept pull requests with modifications. Once you have
   readthedocs.org integration working, we can configure it to be under the
   docs.kernel.org domain, which will allow you to remove the ads from the
   site.

2. Continue to host it in the current location and accept edits via members of
   kernel.org and patches sent to this mailing list.

Please let me know how you would like to proceed. If I don't hear back from
anyone in the next few days, I will configure the perf.docs.kernel.org with
the current converted contents and redirect perf.wiki.kernel.org there.

Best regards,
-K
