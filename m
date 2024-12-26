Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBF1876
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Dec 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228284; cv=none; b=MX15bViptKdsNrRg6vJxg/324LnKwlwuCS6hdKIDnTr8VgM+Le9JCxGhF9Sgd6HcyKpN/pydXXBmsEt8Yw7Om3ISHz9UChdp3WVOeP0ZGQNQQt6LH8/HyBn+hrNmDiLUNAck2DhIfwaVDRdzh44kQgvTQX6lfxP+i/RYWwosN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228284; c=relaxed/simple;
	bh=BM5I1T8tBr9/OVyBQAgRb8HlVRYgiLJlNRBGvI7mznE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiDVx1kDNQ6qbIWai6nYp+srkmG0QlWhTlk44+uEio82IaJZK7QdwjaleRGtKFC4amXPsQ0VqcT91Z1a4uXj0oZP5RR33typeDgoZ671pi80zAPJ/w/Gt/lSwGk892Sr9A67UHHl/hP0/tSTgVb+79G8ylSTlMiXdFpXxnvDg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idDxC0TG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idDxC0TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5663C4CED1;
	Thu, 26 Dec 2024 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735228284;
	bh=BM5I1T8tBr9/OVyBQAgRb8HlVRYgiLJlNRBGvI7mznE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idDxC0TGhcelPgsLzCxu3eNJxgTvzYvcezgBxnvBEurNCGB8RYTfJHSLm1FWkr5VC
	 9pABC8aEvpXzrd94hXLtjcLEzVENe7Doy5SB3lU3URzAgD82tu9j5RovGIduiw29R5
	 pUnyyZGKYTa9HTXpZ2CYlaEzpOLlr1324mV8QGubQ4lfb3sghXMFYQP6eTKwM4zLHO
	 t078yNy3Tbd47n7NT12LSaxeGrFZWegTU0X3CW6EIAF/n9lVYAYvgbD3SkBeqP0PL5
	 JPiyAyORi/RXAfjLNuglEqbdeW3LXDaTGtbWKUJB0eozyKfCKZrY6TbRVXsqiD+s4c
	 eYl3rH2Bxe/vQ==
Date: Thu, 26 Dec 2024 12:51:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
Message-ID: <Z217eBsXIaSgKuSs@x1>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>

On Tue, Dec 17, 2024 at 02:18:07PM +0000, James Clark wrote:
> On 16/12/2024 7:01 am, Christophe Leroy wrote:
> > I noticed with 6.12 LTS Kernel that perf top and perf record/report
> > don't display kernel symbols anymore, instead it displays the raw
> > address with [unknown] as object.

> > After bisect I see that the problem appears with commit 659ad3492b91
> > ("perf maps: Switch from rbtree to lazily sorted array for addresses").
 
> You might want to try applying 0b90dfda222e3 as it claims to fix this
> commit. I doubt that will fix your issue but it's worth being sure.
 
> There was also another fix recently that could be related: 23c44f6c83
 
> Did you try the perf-tools-next branch? Maybe something that's already fixed
> needs to be backported.

Right, I tried reproducing this on perf-tools-next and couldn't, so
please test it there.

Thanks,

- Arnaldo


