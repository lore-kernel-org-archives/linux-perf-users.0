Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963C1CC17A;
	Thu, 22 Aug 2024 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724364849; cv=none; b=of1VOiDqKKlC8QZIGZm73Eh1ZCRjYeRQkqhAhFN3Hv6IDyAmFubzm457O6T5TYZuYCXWKrkA4cJNTwu7aZNWChSFBHHmkvfpcbu4ryrN92Sj07L9OVhLx7GOZsPj/46FN4sq5/M7sySKCPvjs1T1ex5tjP6sakP3WB08SwWxVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724364849; c=relaxed/simple;
	bh=jb43N9TsK73cP08FhYPnstm//ojSGwfD2/0o5mDH2Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQUpN6yyz2RbJsW9Di5Xpw+E+YAPBLbbI1aFeyyT/GDeZQ42O6lOZ8mpzksD/vXr9/tHvVgP/vu14kG4FvlkGuYE2/CmC5bZ0kCFUyOElbUans0NVd4MWG4qmlHjBvXIYTB7S6OSSKPi3x61zB55C2HDf1jPrMXK2sFl/3GIHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLw8NIZr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLw8NIZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCC7C32782;
	Thu, 22 Aug 2024 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724364849;
	bh=jb43N9TsK73cP08FhYPnstm//ojSGwfD2/0o5mDH2Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLw8NIZrP9wqlyLT+Qer/79YOdW1bvFoU8suD+dxVIII+kWTcN0ur7fnW0bpXHhe+
	 Y6MV/2OieRyVUQPl8BUeRjr6Nl2D20dPGe+P343r2EbEgfl6ux2Mw5N96XLZdey7J5
	 VIFvCYe9EEHk+VxO9E6QAq1Mrx8/hPZ8NVliVGuTVGqKqTGbbsPfqL22H5qtMwr4bO
	 kEQq/fmYNkw/vf499EyftM+H4Zt1vUsKGzu8XHpdvZUVNnAobOis3szK/mL2Ry7CMi
	 CJ+Bjh3EKHRQofmJvmrlKCIMcuMWhBOZtO2VdNmakE87JqpjDkrDMS1CQbxQsDlx/q
	 JhPo4wUukiAeA==
Date: Thu, 22 Aug 2024 19:14:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] perf trace: Add some string arguments' name in
 syscall_arg_fmt__init_array()
Message-ID: <Zse4LR6gtIO8-Fch@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815013626.935097-5-howardchu95@gmail.com>

On Thu, Aug 15, 2024 at 09:36:20AM +0800, Howard Chu wrote:
> Add them so that we can augment more strings (which is a file path)
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e7e8c89d9538..84c7398312d8 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1918,7 +1918,13 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  
>  		if (strcmp(field->type, "const char *") == 0 &&
>  		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> -		     strstr(field->name, "path") != NULL))
> +		     strstr(field->name, "path") ||
> +		     strstr(field->name, "file") ||
> +		     strstr(field->name, "root") ||
> +		     strstr(field->name, "key") ||
> +		     strstr(field->name, "special") ||
> +		     strstr(field->name, "type") ||
> +		     strstr(field->name, "description")))
>  			arg->scnprintf = SCA_FILENAME;
>  		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
>  			arg->scnprintf = SCA_PTR;

Humm?

root@number:~# for field_name in file root key special type description ; do grep "field:.* $field_name\>" /sys/kernel/tracing/events/syscalls/sys_enter_*/format ; done

/sys/kernel/tracing/events/syscalls/sys_enter_msgget/format:	field:key_t key;	offset:16;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_semget/format:	field:key_t key;	offset:16;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_shmget/format:	field:key_t key;	offset:16;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_quotactl/format:	field:const char * special;	offset:24;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_kcmp/format:	field:int type;	offset:32;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_mount/format:	field:char * type;	offset:32;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_socket/format:	field:int type;	offset:24;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_socketpair/format:	field:int type;	offset:24;	size:8;	signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_syslog/format:	field:int type;	offset:16;	size:8;	signed:0;
root@number:~#

Skipping this one. Please ellaborate, what am I missing?

- Arnaldo
