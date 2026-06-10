Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DC372B45;
	Wed, 10 Jun 2026 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072264; cv=none; b=GamLGYhMjQlOavYujtPFT/1uo5aolya/r0L88bVk83/t6RbKryUsvo2vs5ztIxYhGSmnN8WHCgcGD7LB1945LTHAs548BQWG6p/EK9CLY6umbVBVOuzKZTd54X1LMAUJfz7lxNS5N9QakRlRX39yB4YrCFPxp0eQTQf8g3gQgJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072264; c=relaxed/simple;
	bh=UAWeR7hUP3bLrsobOVF8T1MNmJV+xvCkerR0WtRSKIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwdy02znYrl4xUoeY8L/oCV20g7LrcikSIlHfVtyD9sPp1QjKL8HUIg9f011BFj8xfwV22a9nG2WkjFGybyMGC4K3FgZ2W2B8aX2B19BFiI5vZqGh5jUIomEyg+k4f42rKY3ooKg7GHwwtN+NQemx8LlNxPp38SxcYe+Ddkjmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BZK3KJ/D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZK3KJ/D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UAWeR7hUP3bLrsobOVF8T1MNmJV+xvCkerR0WtRSKIg=; b=BZK3KJ/Di5lMz8WRfPfczPP+Tr
	SnGjCGVW05hE7QybbO4w/pVj91IWPT2NfR5rq5/CPIF4OZFwvsp7DusX2XViI69+EwE0mruP7ItWZ
	MtUCPnMQOkkc7v2Vrp1vifKgafEr2WAd6ozBxVAp7OdBZPn/pIbCgKf9n6XdFt+zqRZK18pqSxYSp
	4fIIJ5/rREc/rjx12AlEA+im2MT94aYwd7cicf0xwYYAvX4xPHdJyTZi+019qvvmZg2zRqwp6YIw3
	Xl8LzvOPqO4M+iTOggakDpo3KMs1+BA+weEC6xogqKBONBwTH8LSk/qWpCZb71NBnZ8wy8ciPiDIi
	VHNGmL8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCFt-00000006rqN-2BZi;
	Wed, 10 Jun 2026 06:17:37 +0000
Date: Tue, 9 Jun 2026 23:17:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Leo Yan <leo.yan@arm.com>,
	German Gomez <german.gomez@arm.com>,
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/3] perf build: Add libnvme feature detection
Message-ID: <aikBgfn9yZG93sZQ@infradead.org>
References: <20260609070348.541964-1-irogers@google.com>
 <20260609070348.541964-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609070348.541964-2-irogers@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 12:03:46AM -0700, Ian Rogers wrote:
> CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
> TAG=agy

What is this supposed to mean?

