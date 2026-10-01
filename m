Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101E3E00B5;
	Thu,  1 Oct 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870102; cv=none; b=Mt4BOPZLr44ih+Ed8nZGfW+9bDO9Pb1evhZd4/YJiFrt7EI7rMcX5lSnUMl8qLq7s5vOfyLZ4GX2la0ADp0VPtsGsypvE8k2kEKH47l5oHL1eTFhkKdseT+KaNl69WXQ8vz3wfMBLnsjvcnbseXITZyRXL02vB6ow6x2qiMBYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870102; c=relaxed/simple;
	bh=SNuCZLyhrL/dvOwZDXcJDyoGYMKO1kRmJvc6DGGLrGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKCAOA1iQHggWovzupfcY1afv9n+YfN6g2EpA4cRVw6XCA1eAm4qKXDxGaCyabE8THbwjqVu+vcydxKiaD7hEcA31bS2G3SIjrwaW2w6UussK5v5qZG8VL83EtV2HrSLEm61oPmRNkZRUJ/lurFYWZ7Tb2i5eCbOPp8UnNQ6S4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUG6n2iq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUG6n2iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6BA1F000FF;
	Thu,  1 Oct 2026 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870100;
	bh=SNuCZLyhrL/dvOwZDXcJDyoGYMKO1kRmJvc6DGGLrGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oUG6n2iqJqbQJn/VMqxsqkmSt4ec9MpyWYfvsakBk4kuq7xqggrhfA09Y0qIaiHbf
	 FEdYAGZ4o+axe4PxUioVz6h2aJnmqKdEzmnucvfvOkXfR7pBkPftuDUTyZTF+hfN7Z
	 R4Ml29XJcXHA+oiqW5r2ZFqgD1KTgtrzEgCtRQn4VeMvupe8uNQmR6BVxjyK8XqsFP
	 Vnl2s77AkBmZ/L6ZDPNNTTSwC9+NO+EFB6NSxuGIzqDZvsIVBmQ4IdRqckOBYGsSMs
	 TYzH8/IgK8qFSbbEC2lfN+8aJXinxRVzYWFmthhNUArlhiEe2DjEfdOo1pKehexqb+
	 0Un2DAmdoJ6zQ==
Date: Thu, 1 Oct 2026 17:54:56 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: leo.yan@arm.com, namhyung@kernel.org, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v2 0/4] perf build: Linter parallelism and clean/install
 dependency fixes
Message-ID: <ar6CUGUl4ihlJvDd@x2>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001054120.1570943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001054120.1570943-1-irogers@google.com>

On Wed, Sep 30, 2026 at 10:41:16PM -0700, Ian Rogers wrote:
> This series includes a small Python test cleanup alongside build system
> improvements for linter parallelism and clean/install target
> dependencies:

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
