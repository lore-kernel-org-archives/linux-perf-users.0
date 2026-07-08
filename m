Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAF01C84BC
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490728; cv=none; b=DJobQh5BV4qa5reeEmfUPsJwsoSSy29irrKcNQRMGNKN5ZKdaQaZxdcJ+KN7EGCCwtsjUbvZZMH6/3EryfSftGvjuVkKUB0waetIYr6Y1qC/aahOHpgt5Jj0d5NQ8lqYcSpL5gL7ufG0M6CckP7hKAwMjlBCLLaTkJHtLrgAiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490728; c=relaxed/simple;
	bh=jNdanJVTcWkkJkZeDN7BKbyL2gGYj0bTCy5NdNz+DWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIbjLWsg12Wpkkte4UYKTlUXhVX+GwpWOup2AQV57SlnRtP6k0ZHzw0bKFV0J9EijumfrjGyakQPGAZVBnHOcXKyzhA+1YpwUZpWPXVFc46p8oVLeU0Px59caFKY2FFx5IcHZyOsdepRNirmMcDFkcINvRpy3OVMXX1/0cW9kdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjSrKmw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjSrKmw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01461F000E9;
	Wed,  8 Jul 2026 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783490726;
	bh=UNUAL7h75C0GFWhLYoN6/t//Ndh4nenCF1NhVs7dVZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TjSrKmw7UHPYTStSUjitFqxzQMjUF0T9ULD+lOLjGAsG49g5ujy85Vxjppg6IbVzO
	 s9j08fA/1oru76AZ0i4YFOHhPAe+AzzR9ZOPqox3Vz7LGvO+HHdZtbVYeMeUIHppal
	 Q8o0DUXQGB4QdxvpLZDHXaTcDFPGx9J37Cud0fqWCrJLVhuQSH/CJZLLUyaCIfL7WK
	 Hh5IRm5jSZv1AzVckuiUlPvhPquuPMUnh+BrjUva9x7UVbL6a89ijx9TCVt6YeQLtg
	 cwr2BL1ijUb6C0JCyYhsMWjNjpMyHj/F46j8iUhmo92Qf7CnUrl6U6ewqTaL5tf7Fv
	 bnkmzaLHF9oFw==
Date: Tue, 7 Jul 2026 23:05:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-ID: <ak3opN58uZ1UJzfs@google.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1>
 <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
 <akWEgMBK7Y39sgc8@google.com>
 <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>
 <akhM9-d-tNjZzb-A@google.com>
 <845be1b6-8e56-46fa-a258-5b0033fac474@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <845be1b6-8e56-46fa-a258-5b0033fac474@linux.ibm.com>

On Tue, Jul 07, 2026 at 07:36:06PM +0530, Tanushree Shah wrote:
> Hi Namhyung,
> The only change I had planned for v2 was the fix for the pre-existing issue,
> which has now already been merged separately upstream.
> 
> https://github.com/torvalds/linux/commit/2857a5dca750ea989c6fb70b4c14e801e4b7b4ad
> 
> Please let me know if there is any additional change you would like me to
> include in v2.

Oh, nevermind then.  I'll process this.

Thanks,
Namhyung
