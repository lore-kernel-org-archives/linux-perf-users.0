Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D118C05
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617746; cv=none; b=Mu5f17IAqbY7AKJb7Pb4ql+Eu5cvcHaO1+9rWO3WOTdlrxHhEa+pwYolAMfSxOvgOxICs8FTytzmKavuLiXLOEzt4NYJovwwOzpDxJyuMQR3ptt46qsr/6T9elvNhxDj3D41p7LtURSN7ufHqoitCy+q6BQIyxTJ5usl68hSQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617746; c=relaxed/simple;
	bh=TPkHJJre/fBBn/tRBy2O9wRECv2XZKDifq56U7buxN8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I2WmuGeQHN2bTSMrRc8NmP1N/ZnH06NmlfzdMRmnrwofSUbHMQm8ZSc0fAA0mDOI9FWJrgxF2x7Pq8dnLK8PYOgIOucXhu7UZ1C4Sx7Ey+Fn0RMuZ7bt0LT2FGvHxsYfO7KjX8o07UUmdE9oiEDkXUy3Btfm0tJmvc95SO+CGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8wrDZ6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8wrDZ6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D4BC433F1;
	Mon,  8 Apr 2024 23:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712617746;
	bh=TPkHJJre/fBBn/tRBy2O9wRECv2XZKDifq56U7buxN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8wrDZ6M+7es5m6EKNO8StPTUDCJKgxUgR4teS/POPXCBXIIBQnwOpYrsoAuR9/qb
	 iWBvikT8nRPsAzy9gDEAIfpZc+yqYn4L2rP+iHacR3WpsxipQ9teWX2vfU7qMhSUox
	 hTMi/1HEnRKJppO0MB+QoTfW4FlW6Z0dHdGzQxYLEjTmzoh82LlbRN3gZgL/ZOLn5K
	 /rCIsu08ThMs7JTRuHtIROQSDp4Nuqg6O4tLgTHQj1felhNIirvJFPaJYtXcQR6JYG
	 tEDHaazUS0DMIm/VlwTNATM5EYBiejGNlxLAbuDBksZIwv/AiX5Js2kVIbsqaytIeT
	 5nNR1LbBvZ0oA==
Date: Tue, 9 Apr 2024 08:09:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com, Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: Re: [PATCH V2 8/8] perf test: Check output of the probe ... --funcs
 command
Message-Id: <20240409080902.6f2ccd1239c64ca49861d6d6@kernel.org>
In-Reply-To: <20240408062230.1949882-9-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
	<20240408062230.1949882-9-ChaitanyaS.Prakash@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:52:30 +0530
Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:

> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Test "perf probe of function from different CU" only checks if the perf
> command has failed and doesn't test the --funcs output. In the issue
> reported in the previous commit, the garbage output of the --funcs
> command was being ignored by the test when it could have been caught.
> 
> An additional check to grep for "foo" has been added to test the --funcs
> output.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> index 319f36ebb9a4..82bc774a078a 100755
> --- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> @@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
>  gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
>  gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
>  
> -perf probe -x ${temp_dir}/testfile --funcs foo
> +perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
>  perf probe -x ${temp_dir}/testfile foo
>  
>  cleanup
> -- 
> 2.30.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
