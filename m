Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2012CD90;
	Mon,  3 Jun 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417254; cv=none; b=T5n9+4Gd3drKbEhMcOg5d3Z6EGgV1Yldg84NIcmispsl4cEFcusjjQS13gVyk4hcdezKyfhlLkEvVEYJxMYbUimR58Yq0O4bljVBMzUUTpbEMq+aC80MMKEjtY1Inzb+jsi9p/h7ZKfyHSB1y76gNTqFgkUk+UCfXieqXF0qGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417254; c=relaxed/simple;
	bh=ta5D7kyiWnA9Mm2UQRUAyhSlkMKZWClYfpFJ1WiibAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ3WjKP4sJslTHCS1yafu8B7TbGTe9DgEdqA4r36DStP5byHfc+35cpSN0QkJn8lzxdY8o2xaGAwdxc0lLEMQm272fiSHVL9PQBhVTeeox0gOV6RKFfihJb3I0IOVembMU3qXHoRn01W27gj65VqeQYaTXfOZK62SBiq1F6ttA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E71591042;
	Mon,  3 Jun 2024 05:21:13 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 973303F792;
	Mon,  3 Jun 2024 05:20:47 -0700 (PDT)
Date: Mon, 3 Jun 2024 13:20:45 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Haifeng Xu <haifeng.xu@shopee.com>, mingo@redhat.com,
	frederic@kernel.org, acme@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] perf/core: Fix missing wakeup when waiting for
 context reference
Message-ID: <Zl21HTPYooCEO8l0@J2N7QTR9R3>
References: <20240513103948.33570-1-haifeng.xu@shopee.com>
 <20240516085106.GG22557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516085106.GG22557@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 10:51:06AM +0200, Peter Zijlstra wrote:
> Thanks!, I'll hang onto this until after the merge window and then stick
> it in tip/perf/urgent or somesuch.

Just to check -- I couldn't spot this in tip/perf/urgent just now; are
you still happy to pick this up?

Mark.
