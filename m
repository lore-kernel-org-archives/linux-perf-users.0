Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2617BB16
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016703; cv=none; b=tntzR2Ew3NfRh9zr9cZlcaSv4m2w2t2Afynj7cPi+o59vZetE9PSNThI2TsaROIh2iK2Ah/K4oFFU9ZRW2NEMHTQFkLN63jT9yZF9Eh23zBhsVi0zWGkvERob91vPkN2AT2+UJzVn4GmaSWSqnIjM/HeD9A5tJCULkmMLRZyQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016703; c=relaxed/simple;
	bh=eIOtiQ3wtxtX4ixU6bIp0TSpxQV4Ln9Q7+V3TWe56fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuWg0JVUDIA5XVwIFmQBu555oe/3iA1uTZSAzyqstqat/v/EIZnYzHN4zzKxsbJoMcMeydq/wAfcZSbJBU7lcQrFxskk8o9b6EptMN2fPFyLWYO8L4KRRL/Ep4PrJZRGp3HWjbieDRfUnUMK2D1XqlOWForeRPed8tDFp54Csnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Azb97/2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Azb97/2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279E6C4CEC7;
	Tue, 15 Oct 2024 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729016703;
	bh=eIOtiQ3wtxtX4ixU6bIp0TSpxQV4Ln9Q7+V3TWe56fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Azb97/2CCsAIMKKgUA5OvBSei7xp8NOeW/Suf7q4Ve0cK3ubVb9wR7LCdx/Fm2u9L
	 XeAWf+JW2dvBDECxJBAHkNiz4xi+vKraAEuEaCeBn6KCGN8YwBJZr5IjU0s2OQrN+l
	 GGmlHGVhlGDRLneRl2QgkA0EStn49foTwvy49NRI=
Date: Tue, 15 Oct 2024 14:25:02 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
Message-ID: <20241015-warping-condor-of-storm-afa06f@meerkat>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011-uncovered-original-vole-cda87d@meerkat>

On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
> > Yunseong created:
> > https://perfwiki.github.io/main/
> > Perhaps the solution here is to make perf.wiki.kernel.org a redirect
> > to https://perfwiki.github.io/main/

To speed things along, and since the old perf wiki was near-unusable anyway,
I went ahead and set the redirects from perf.wiki.kernel.org to
perfwiki.github.io.

Please feel free to follow up if we need to revisit this, but things look good
to me with this change.

Thank you!

-K
