Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E4438229D;
	Wed,  8 Apr 2026 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647003; cv=none; b=KJTUrQIQPOQf0LP0PANLF4BMH7pfOGi6rC+Q4fXTeaI8UCXpKJ5b1puq02k3clHERIlWU+DtVHbEM/+A36brkdqnvG3sGUmX/GiIB5iRBcYv3LckhvSTD88vbadNVahW8Nw3yOXvZhF+wx9ZpseDvctLse3aQqoM/y0DYC/MrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647003; c=relaxed/simple;
	bh=uFbMXrldq36UH6h3zAVxylgeW7SVg8YvoOzRknXJSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCmfYlThboNcbnDgPDe8/h/OUfbqXL+6ynYk9O0o/lPBLcIeM1qA6TXgtb9oCDDfUw0G1sHH6pvjvMe+wT6+2Z8xsLKofA7W8uRBknFaHEkjo2TdtT6dgo/INxG5gSwldPdqYCCkbm4oYYKLlLKhTIIlFu5kHUB5cZ+7DPkfwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P1bjmjpC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1bjmjpC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uFbMXrldq36UH6h3zAVxylgeW7SVg8YvoOzRknXJSSw=; b=P1bjmjpCaOgzgJVjOk1hfmq5Di
	BO4I+Jbwk57MjUT5mmSNxC75RvYtheinmp6CY7ZoLxCdUJRZWR1o4hVrock8zxi885YpT9cnDw5vQ
	5otBNk2rq4lNSj+6BuuTKXo0nOq9tGQvcaPKbDpO5OEq+P6rDaFhwffVLS/SvpPFk6TVf13ET+BD7
	iO1Y1faEpUcmgHX7OjkWfYRdmZDLckZKo7jFiBImSFv8EiucEh8I59bKL9uLoqEB8TsPQOePn6/yF
	v2r96F88Z8Cj9a63FZS+4eKXugUWu+d5TLupSOuwzKllNVEq+VPqKIcr99NA+hhMHctve/BFXaEDo
	9su6MsIw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAQte-00000009v7A-3fvD;
	Wed, 08 Apr 2026 11:16:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A46733021A4; Wed, 08 Apr 2026 13:16:32 +0200 (CEST)
Date: Wed, 8 Apr 2026 13:16:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
Message-ID: <20260408111632.GI3558198@noisy.programming.kicks-ass.net>
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
 <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
 <c7688962-d10c-49e1-a434-ab7ae2c64cdb@kernel.org>
 <20260407071820.GA3738010@noisy.programming.kicks-ass.net>
 <bcf784d9-5350-4b43-a827-a1cead862cad@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf784d9-5350-4b43-a827-a1cead862cad@arm.com>

On Wed, Apr 08, 2026 at 04:28:48PM +0530, Anshuman Khandual wrote:

> It would be great if you could pick this up. Thanks !

OK done. Should be in tomorrow's -next I suppose.
