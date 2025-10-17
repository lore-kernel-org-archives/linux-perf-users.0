Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B230F951;
	Fri, 17 Oct 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704149; cv=none; b=ZyXz+/4MnNJZPLz2TgvuTazHasMZZ6ULXPcAVvOHK97U94cd+TkDiVBUaiaUAXkTfhvZTCrdS6HNgiEsmAsXCZKDrSx2lc5LD+NjjcSyPbofKtqS6SdKzoGCpCXMUoCskIbeEOiMD6uy5Q6oQk1Gn5vZJ7RFRZfqzOxybWatntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704149; c=relaxed/simple;
	bh=mbmBwEbwkAUHwpJy6E1FCPPNuZxST6LLw4ZV/OAAVXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjgiISgGkzACWfVZTBvQ9nnEo5RCw+3f2wLCxDOyQkNx4/xrTbuhylF2tMlDoZPh4HhpWo1SQFfSmPVc/vBioV2XU3opBwJscXvVUvmNC+ra1glhgH9NDrKBXpOzIh4eRz3Fje/eDa50vkkPiTyadzQlmcjyYMrrcoQTlIXerVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFB011595;
	Fri, 17 Oct 2025 05:28:58 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4699A3F59E;
	Fri, 17 Oct 2025 05:29:06 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:29:04 +0100
From: Leo Yan <leo.yan@arm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
Message-ID: <20251017122904.GC281971@e132581.arm.com>
References: <cover.1760617634.git.geert+renesas@glider.be>
 <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>

Hi Geert,

On Thu, Oct 16, 2025 at 02:44:12PM +0200, Geert Uytterhoeven wrote:
> The build looks for "python" and "python-config", while modern
> distributions provide only "python3" and "python3-config" by default.
> Suggest installing "python-is-python3" and "python-dev-is-python3", as
> available on Debian 11 (bullseye) and Ubuntu 20.04 LTS (focal) and
> later.

Seems to me, this change is not necessary. The Makefile [1] searches
python[2|3]/python[2|3]-cofig if un-versioned executables are not found.

I confirmed that I can build successfully without installation
python-dev-is-python3 package.

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Makefile.config?//h=v6.18-rc1#n302
