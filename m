Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0B2063C4;
	Mon, 16 Dec 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371461; cv=none; b=MJqBuOYlrLyli0Z/v/pPECAbOAmWbEoL7vk4juV4jNnvxeJGbWmEBqBwaoSJ5V1FS7coj6gC+QXownBOvrqqRPC5Fj4pLbtnNh6ogxHwtd20m5XpaMECydZWSeIYQmfIQ+dd1mXCcVvbbs/ULZbSDC/fU29GS7f5CIB3/eRsQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371461; c=relaxed/simple;
	bh=XPoUp67ed4JoOg0ycSqESbmQXikBffSLNT+vnSBT4A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmvEC8htbZA5+NLIMqY+t5ziUvBqfTXd6q87+cHJn5mtAYYYYToxQrgS4Cq3coQv1B3MD8Itq4IKhbH3mUAbrC0YfDdOSN/KOQOJ0pFRXypdq6r+roYmWM7/cKA807KqjxOgyBeY7EbONdgWy0OTwlQKS2NcYWghy5XenFsrOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUS4EupW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUS4EupW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DF0C4CED0;
	Mon, 16 Dec 2024 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734371460;
	bh=XPoUp67ed4JoOg0ycSqESbmQXikBffSLNT+vnSBT4A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUS4EupWCBbJ4rlfyoEiW4ciIRhZ5qiRuwpunzyaQG3ilqwaMambY46hLzMM41qHT
	 EEpvStm/JYTKjnpg8Vy+RZxCwK8ShsJQj4GjwG2LFAxahBpQ7VM0ItLOTUq7Oruw/v
	 txmBU8VIyVNMlEFJZIhXRr3COxm1e3oquzPuz71T6ZZfYRZoXm7mgQgHVotqRlBjI+
	 TVggZZdQeUtAOe1j328RfyjlWcxw+3ToIKhNA/31GfNtqpXxG565iTvfZ+2o8Me/VQ
	 ru6bZ5QEjtb+zY3wmOneJIIlsOB/+ZLe7Gy07jGhPe85VJAh9pWTT8qEtf0Bkm8tJJ
	 FkbMx7zVewG1w==
Date: Mon, 16 Dec 2024 14:50:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kajoljain <kjain@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, mpetlan@redhat.com, vmolnaro@redhat.com
Subject: Re: [PATCH V3] tools/perf/tests/shell/base_probe: Enhance
 print_overall_results to print summary information
Message-ID: <Z2BogUY4sx8mqrAg@x1>
References: <20241206135254.35727-1-atrajeev@linux.vnet.ibm.com>
 <32b19139-27f2-4f39-a2ae-25027acc980e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b19139-27f2-4f39-a2ae-25027acc980e@linux.ibm.com>

On Wed, Dec 11, 2024 at 05:33:50PM +0530, kajoljain wrote:
> On 12/6/24 19:22, Athira Rajeev wrote:
> > Here -a and -d doesn't require DWARF. Similarly there
> > are few other tests requiring DWARF. To hint the user that
> > missing dwarf could be one issue, update print_overall_results
> > to print a comment string along with summary hinting the possible
> > cause. Update test_invalid_options.sh and test_line_semantics.sh
> > to pass the info about dwarf requirement since these tests
> > failed when perf is built without DWARF. Use the check for
> > presence of dwarf with "perf check feature" and append the
> > hint message based on the result.
 
> Patch looks fine to me.
 
> Reviewed-by: kjain@linux.ibm.com

Thanks, applied to perf-tools-next,

- Arnaldo
