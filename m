Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6435DA69;
	Thu, 16 Jul 2026 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784241131; cv=none; b=Lp4MbBsgIMQ0D5/JyYZr3HG76wm+3vyoCFdmZ8aXFFxbCAMpNbKDoaRuG3a7AZMMWmq43pR/aqOl1X/BLPYve5gGMejVsZRAwum1dJ8RaMliE/CRiRp2GWsMS8F7mkVOsRYAwCEGxI3jx7XB7wEAYaAltrFoHWBBXXV0gzwkuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784241131; c=relaxed/simple;
	bh=QAwX8Wu5LLo58tVKfwRC2H5UEzuI/5d0B7B8v4uwsqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBfRaIZDmH18Jo3UyHAebrLlmWbOIMVlZeUDVeuJabMXBzRnhncf/UySG8q4RzIzCbF/bp/5uXXP+KUfmE14Wpg0c1SkBAHs/ggq7Af7TKEYU3XMEwmku0zDex5ORszeGGd/NWw5Qu9qBwY1vRRNXLmNr7b1OsiWHvvgyrKAJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIPVuuUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIPVuuUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FBB1F000E9;
	Thu, 16 Jul 2026 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784241130;
	bh=gNb13E35xARvX7szS7Z0XN4SRsYk3c+98FqnNicO5BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cIPVuuURzaI9knXjzi+PC++gBqItI3QN6AFMjBReeS3U9waoV7tG/cxiIDl5qQXU9
	 J491hyqX8EejpWTu98w1D+5zkiWywakkj9H9vqMh7zkNWlQiHmukHxeCzDzPdGchBt
	 jgIiXR8qKrP8SfDiGep9v3Y8Db4tkLPl+lIOs2rERO8hFDiAKSs89l5EfwWvUDSOl+
	 TOraqqvMf7qL6ezajcWeV0T4JMUtsBBrO0CG+eY2Zca1VTVsZuV0RmYMafmFdMOy3D
	 /9xTCMPrgRRXux0TscTlw+XtOT00TjplBvjMOqWqMVIbzAEMr9XOQxnUvuomi68Bfn
	 FCVS5WZ2btQOQ==
Date: Thu, 16 Jul 2026 15:32:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ctshao@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 06/14] perf stat: Extend STD output linter to test
 metric-only checks
Message-ID: <allb6KuDNpyFbqJA@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716070303.507066-7-irogers@google.com>

On Thu, Jul 16, 2026 at 12:02:55AM -0700, Ian Rogers wrote:
> This patch extends tools/perf/tests/shell/stat+std_output.sh to run the
> metric-only check under the --new print flag:
> 
>   - check_metric_only
> 
> This guarantees that standard console metric-only outputs produced by
> the decoupled printing callbacks are formally validated by the test
> linter.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Acked-by: Chun-Tse Shao <ctshao@google.com>

Can you please combine test changes into a commit?  I guess it's ok to
have separate one for std, csv and json.  But I'm seeing this as a
temporary changes and we will remove it once we switch to the new way.

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/stat+std_output.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
> index 0d38a1283967..69720b19b908 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -134,6 +134,7 @@ then
>  	check_per_cache_instance "STD (New API)" "$perf_cmd"
>  	check_per_cluster "STD (New API)" "$perf_cmd"
>  fi
> +check_metric_only "STD (New API)" "$perf_cmd"
>  
>  cleanup
>  exit 0
> -- 
> 2.55.0.141.g00534a21ce-goog
> 
