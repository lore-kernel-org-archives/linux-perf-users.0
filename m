Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2E25B09E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018062; cv=none; b=DRNb+KO+SoJG//oqrjD4FTlNSCSdW/yGBiChbus5IXgQHEsmDzneCL5TA7BsMiX7D0lVKzTPE48YXO0sLo6Qy0MVDhfcb9XX6RxyH8s96jWakvwvaj/U+D0kJBYQE04vb4oUrIQwrJpO789dhpHv3Oe8XYfw6JgkYj30oPRTo+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018062; c=relaxed/simple;
	bh=lL1y+thte5mtjqiwl3OwOxaHm3Mn6o7NcqxBiiwXqyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpXxjmqEcmKEdc9WF8PAFD8vUGLHccW2T2FhKm+/cBKWqCbt3UK4eJ3chzao4y/4e8nzae8TbalSz6LHZFD7hK3YHaMdxrNkI0BpmjgEe7R4OkykXgiLm/ClFuEXnuiWbX3K8HuAuFBdwqkCwkKbpiDJUZZnQYdUTHmUgI7lIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg1vR0XZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg1vR0XZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631C41F000E9;
	Thu,  6 Aug 2026 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786018060;
	bh=/rGqzBb0sYOGN7VR0c1ptkLaLOY684Y9Zkrymft+ud4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cg1vR0XZ3XOyvNTpvh+5zuMK2t5GW28Es/jpHHkwWWXgyVOv9bS+o4jzDRxBN0OuN
	 kz2el/iqQr+/Fotp9GCCmFMC9exIbsFirTa6yN9YG0/DaqG352LPFH79bu7MH20HXX
	 FF72e2eGO0d/txciGcXt3AzbTEhffsOLXPL73CUfTaqj+2lqPUBtqTmjdm87GW8KRH
	 oeEkon+UvcB9y8z0zarYmUS8tTQZzKZVpdwCkCPzY036j6e/pZAM8xC3F7T03egip3
	 dDwB9q3Ijy6hHjl8bzxjIQFvdMJHgW5PLohHQvSFBhOn6HuuCwIzpE094yyrH3VmnZ
	 Q+S0Mjkg1YpiA==
Date: Thu, 6 Aug 2026 13:07:36 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com,
	leo.yan@arm.com
Subject: Re: [PATCH v2 0/5] perf/arm-cmn: Support CMN S3 r2
Message-ID: <anR5CDq3efkXzgG6@willie-the-truck>
References: <cover.1785252273.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785252273.git.robin.murphy@arm.com>

On Tue, Jul 28, 2026 at 04:59:20PM +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/all/cover.1782830759.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Since nothing else has come up, this is a very minor respin to fix
> the bisection nit that Leo spotted, and hopefully it's good to land?

Please can you check the comments from Sashiko?

https://sashiko.dev/#/patchset/cover.1785252273.git.robin.murphy@arm.com

Will
