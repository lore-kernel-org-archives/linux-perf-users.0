Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884902874E6;
	Thu,  4 Sep 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972005; cv=none; b=ppoeWbUKc+Ia8/t+w7skwba94A9wq4851sXoHibREYrHJR57sg0051czEt5UtyXWG5ntlX3hxB713RuTIa+mvLlWdl6rDNAeGsnMbg1wz5ACWwno66Y3ML8kntM7nCvpTcy88qwWCo0ZBJt/3ZUHl8FVCdYeerJo5Ousw7sZjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972005; c=relaxed/simple;
	bh=ayhnFOvBI35lN1QuVk6R0qQPQ85LgwB6FlWmSDytSD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf0qAZH+/ZRvJwGs+ov0NfigN4AVqyzPjVDDGZdglKTLNpj7jhu5+fZSOeCSS1PIUvUs98E/rkyjyTAGtnXw0i7uzajZA+4qp7EzTuYVBsYdaoHuv3rWpud52zr/bWwmLBZN+qu7V/yTm/3Rx+H6Urp9F3QtDAo4ybPhROl+vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei8kWMgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei8kWMgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3113CC4CEF0;
	Thu,  4 Sep 2025 07:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972005;
	bh=ayhnFOvBI35lN1QuVk6R0qQPQ85LgwB6FlWmSDytSD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei8kWMgvmOrl55vH/goejl0rRfHpQQ1VmNfXzvHDz+lTW0OMkPved487WEfKf7TiY
	 KUNMyus/fVOJTuujNmC9bMhq+b90A2Zz5no4E5gchShcIjFAp3C0qq8ONOlyrsP3tQ
	 +ximJtJTMRJlFQCtfQD537bk775UQQ2nitfJpfBZ+gtDiQZdBjVO7lZcQnf4SNLq/0
	 UXxcYiDXmQJczRfJTfZuX7iYkFm6I1ypem81PHfCTyHAkg8RENBZZ4TOux6iEpx9cV
	 hQLAvTaqU+wqtlSd7RHiRrc05M7CVuS00EFQrenJKysh14aiq2C+dxydSw3KfDUySQ
	 1cUCcdAhFXjgw==
Date: Thu, 4 Sep 2025 10:46:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/18] mm/ksw: add build system support
Message-ID: <aLlD2CDengxSl4fS@kernel.org>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-2-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002126.1514566-2-wangjinchao600@gmail.com>

On Thu, Sep 04, 2025 at 08:20:58AM +0800, Jinchao Wang wrote:
> Add Kconfig and Makefile infrastructure for KStackWatch, a real-time tool
> for debugging kernel stack corruption.

...

> +static int __init kstackwatch_init(void)
> +{
> +	pr_info("KSW: module loaded\n");
> +	pr_info("KSW: usage:\n");
> +	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");

It feels like this belongs to Documentation/ rather than the kernel log.

> +	return 0;
> +}
> +

-- 
Sincerely yours,
Mike.
