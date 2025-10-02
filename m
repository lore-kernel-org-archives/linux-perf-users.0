Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53306278158;
	Thu,  2 Oct 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428376; cv=none; b=XIpG8hqD7TCbaGo1Fc8NGYRB5FD0keZ+opj6IHkYSPa1wQLVSTQmbEKEUNdxo72O4GCeutjJybpKF9suoIsCxvRpTs/0QQnOva9K087B3AMjTPBOqgQAK69v4oIaU1VJdvOEo/MjOPho5q0wmOQlyxfiHApUAF2btv4EiPBOXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428376; c=relaxed/simple;
	bh=se/X+qg3t5OQNTeS/EQdW/zMcnZDvKL3vDgGD5Artp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5poAzFwAm/6zLBLPILwlEKno9F9l1xHOfBcOdFjYAhnbenMsurnIspF/FG3FGNzEz2d8S2QIYSXC4GXM2gnClpJW0TN/m9JvKFj7PSxEPHUhHVyEKdpaK0tpGihXJ8kohCkJjDyujOC1crNWEX2Up+r8fqMpou9RAYWb651plM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6goixbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6goixbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FF9C4CEF4;
	Thu,  2 Oct 2025 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759428375;
	bh=se/X+qg3t5OQNTeS/EQdW/zMcnZDvKL3vDgGD5Artp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6goixbAeGXlM8C419Xbjkxsbgm5iUi53+4lMmDZYBlWbJNd+srExivSP1aZQeAua
	 RSeY7OVDzwkkS5CFhq2Pt7suvGK4BZnyq3WHylVctJjI5GWxNNXEpWxzKASkTsHavx
	 U/SAYP9aFfxFm2AN5E1aG/YBGbsteH85GWYAqDwKCqet15gwpGKdeCcr4IIFjy35zf
	 kxOboNkCsgYzGiYfFzBATbgsPWJh7Nt6N58gHKcmXlDx8F7zc8c6qUy7chkdaoGPbC
	 l+x+pcnGY/nJnbJDFRy6IQfLWcaieJxWEW3IpqTTqA3hOv3nIzpzV54pRt82ALP68N
	 5diiB9Gcxn4zg==
Date: Thu, 2 Oct 2025 15:06:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Stat std output don't fail metric only
Message-ID: <aN6_FKWEfYLmUhw0@x1>
References: <20250914182140.1958530-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914182140.1958530-1-irogers@google.com>

On Sun, Sep 14, 2025 at 11:21:40AM -0700, Ian Rogers wrote:
> When running on a hypervisor the expected IPC metric may be missing as
> the events may fail to be read. Don't expect metric output for this
> test to avoid it failing.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat+std_output.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
> index 6fee67693ba7..ec41f24299d9 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -90,7 +90,11 @@ function commachecker()
>  		}
>  	done < "${stat_output}"
>  
> -	[ $metric_only -eq 1 ] && exit 1
> +	if [ $metric_only -ne 1 ]
> +	then
> +		echo "Missing metric only output in:"
> +		cat "${stat_output}"
> +	fi
>  	return 0
>  }
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
