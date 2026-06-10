Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E33DDDC9
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122087; cv=none; b=junl0yBarDOhol5IRYMvPGAmOWIo0CGCkyK3StZyYH9pSCEKPr7MtWYvc59pVfqX72HnqCbPNir7ClPd+v/so1LbXYq4tzEgRGeyhBWrrRtQx1/KHEDpEoc7i/R8bC1K0wO0CVAalaIXAU0BxhXkfxCKUygPSiOJWOzKYHa+pT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122087; c=relaxed/simple;
	bh=stOAZYsbgJChIIA8gJ57kl6NPczJg+5VCILKjXJ6Qw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpxu8Rqf9dTzQrjkxBJFFSQtMDv9fzdWujXygJ6jXBuKAtO7/790PzIX0qn1sftI3uAwjO+aRHjHAhRcetG9sLkwziiVJwUVdyfgVU62qQvrb2ay9rp+sL7x2oMbDGM3ljb0dggNaRJTHzfeZwXNEnPW53yQMc1cQpiwLlCP1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW8obmMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW8obmMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D061F00893;
	Wed, 10 Jun 2026 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122082;
	bh=stOAZYsbgJChIIA8gJ57kl6NPczJg+5VCILKjXJ6Qw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TW8obmMS5PP67mj7wHlY9i1VkMJ/ZI/klOqkJ6ib8iIrdgA/aiL098zlnb3TszHm6
	 5XpmMPkm12zHgD0K9nRR92r41myUHsvQGuKrc3O7aULGC08BryXm/o+PNE6MyHFM1o
	 A3+ceEm+yU1nGIvYJBlNF6+Ht6qMpDMfq1o5I1vng5sQzLtazE30cZCxJRaITruKMl
	 XAkEGV4YsIUEXwYJLUvM5ur1VXbwc4ieqwxUpmTGdVJx9JDcKxej45+cOqSw5GUK+h
	 A2lFkjD/D4a3pW4cnItz/dTah/LsgpHP+Qo55zp3wSCPIGF29t/VKa+G8dZTYrUFB8
	 F6rBQ0Z3bkBcg==
Date: Wed, 10 Jun 2026 17:07:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
	namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com, venkat88@linux.ibm.com
Subject: Re: [PATCH V5 1/2] tools/perf: Fix the check for parameterized field
 in event term
Message-ID: <ainEHlAh0aJ7zSyH@x1>
References: <20260609134332.97954-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609134332.97954-1-atrajeev@linux.ibm.com>

On Tue, Jun 09, 2026 at 07:13:31PM +0530, Athira Rajeev wrote:
> The format_alias() function in util/pmu.c has a check to
> detect whether the event has parameterized field ( =? ).
> The string alias->terms contains the event and if the event
> has user configurable parameter, there will be presence of
> sub string "=?" in the alias->terms.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
