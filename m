Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AA182;
	Thu, 26 Sep 2024 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727308982; cv=none; b=lFLmHWd2d+NdWT1u9RAn/qJ94slfbgzfR99T2YjEM3jTj7/pQWBapcSKP/6XdGFKV0WpTq4NVHKUT8UQNbInnPN9iTlKx7Mw2JGoDwV2KyPk8BkG94mdhZSCbENEJe+bJksaoXqRW+stq9g0RuKc8YqRpgxGdnbUdHgj9UgoCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727308982; c=relaxed/simple;
	bh=7IfVre6eUidj9vxBW0Hmx+hf7FbuM15xvB2SgHu1w/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiHiQelxP3aeW4xykWLG6h1JT46NfEuzhm7WXbXckomglVM+uYpfOnNPUCIe09CsoX2DJAkN/two4Ni/RdfzMFA6EE0ja/6agm65t087P1ozYw4COkvaAyXY8WqyROxTjlBqSfQa/4oWVhGghytea/cpmmcShNuGsBByEwK68t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNRWGLgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNRWGLgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773F9C4CEC7;
	Thu, 26 Sep 2024 00:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727308982;
	bh=7IfVre6eUidj9vxBW0Hmx+hf7FbuM15xvB2SgHu1w/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNRWGLgHv8gowFEaZ+yd7a0u0Wa6+Gq1C/Oy6gI3ULldhN9PZqGca2jefBBTZujW3
	 SyicsWxLGtjTrYuzH+l3fnRVx5kms0obJPmupu1LiwMFGtUUvmJQmmk01ge2sy8aEI
	 T4GdQnLBYg2LPgFs//eGLykSAVndSEoa242zxnA9vDs5KYrYzT3WHG5SRk4QuyP8Kt
	 9re9xpH/EVnIn6ZRpZmiR1pxp0eayEZ+cR5syXSQ5ftQTAkoVHjb/4Xk7JKb7mlw+2
	 TIIqZsNZ0pCwUT9W/JP/C3L8nRdnAOwqFq94MqJcI9NzEgxlqAHMMq0tROVieuWYNo
	 oOwlJ2jFJMdkw==
Date: Wed, 25 Sep 2024 17:03:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: StefanEne@google.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, vinicius.gomes@intel.com,
	stefan.ene@intel.com, stef_an_ene@outlook.com
Subject: Re: [RFC v1 0/3] C and Rust support for perf script
Message-ID: <ZvSktIhEOtnmrvUR@google.com>
References: <20240919215107.2263552-2-stefan.ene@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240919215107.2263552-2-stefan.ene@intel.com>

Hello,

On Thu, Sep 19, 2024 at 02:51:01PM -0700, StefanEne wrote:
> From: Stefan Ene <stefan.ene@intel.com>
> 
> ============================COVER=LETTER============================
> 
> This proposal is addressing the usability and performance of the available scripting languages for custom perf event data processing inside of the perf toolset, specifically with the perf script command.
> 
> With the perf-script custom event processing functionality for C and Rust, we noticed between 2x to 5x speed improvement with our new methods compared to the existent Python and Perl scripting methods.
> 
> To explain the proposed method, you begin with the C or Rust script we’ve templatized, then just add changes for custom event processing in the preferred language using this provided template, compile the respective script into a dynamic library, then give the resulting .so file as a parameter to the newly implemented perf script option.
> 
> List of functionality additions:
> 
> 1/ Added new "--new_script" option inside the perf script command that takes in as parameter .so files. Code addition in tools/perf/builtin-script.c
> 
> 2/ The functional code for the newly implemented option was added to the tools/perf/util/new_script.c and tools/perf/util/new_script.h files.
> 
> 3/ Folder added at tools/perf/new_script_templates, containing C and Rust script templates for the new option, along with compilation instructions.
> 
> 4/ Finally, a short bash script for updating the perf tool set within the kernel code was provided in the base-level file update_perf_tools.sh.
> 
> 
> Common Questions
> 
> * How can I use the new toolset?
> 
>    The new implementations for the perf script have a detailed usage guide inside of the tools/perf/new_script_templates/README file, along with some script templates for C and Rust!
> 
> * Why a new option instead of expanding dlfilter?
> 
>    The new option gave us the flexibility to make use of the fast dlfilter dynamic library approach, as opposed to implementing another interpreting methodology. This allows for scalability, with great potential to other languages supporting dynamic library calls from the base C code.
> 
> * Why use C and Rust instead?
> 
>    As of kernel version 6.11, the perf tool has a large overhead for data processing using Python and Perl, given the languages having to use their respective perf built-in interpreters. Furthermore, while Python is widley used in the development comunity, as of 20204, Perl is only used by 2.5 of developers worldwide, while C and Rust are more common, with 20.3% and 12.6% usage, respectively (Source: statista.com).
> 
> * What are the actual performance improvements?
> 
>    As last tested, the C and Rust approach are anywhere between 2 to 5 times faster than the existent Python and Perl scripting methods, with Rust being the fastest all across!
> 
> 
> Acknowledgements:
> 
> This code was completed as part of an Intel summer internship project, under the mentoring of Vinicius Gomes, Intel Linux Kernel Team.
> 
> =========================END=COVER=LETTER===========================
> 
> 
> Stefan Ene (3):
>   add the new perf script option (--new_script) and related changes
>   added the C sample script
>   added the Rust sample script

Thanks for sharing your work.  But I think there are many more work to
support scripting of native languages properly.  For example, you need
to resolve symbols and callchains before passing them to user.  And we
might think about the safety as it can modify the internal state or
something.

Thanks,
Namhyung

> 
>  tools/perf/builtin-script.c              |  22 +-
>  tools/perf/new_script_templates/README   |  65 ++++
>  tools/perf/new_script_templates/lib.rs   | 108 +++++++
>  tools/perf/new_script_templates/script.c | 113 +++++++
>  tools/perf/util/Build                    |   1 +
>  tools/perf/util/new_script.c             | 376 +++++++++++++++++++++++
>  tools/perf/util/new_script.h             |  54 ++++
>  tools/perf/util/new_script_rs_lib.h      |  35 +++
>  8 files changed, 773 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/new_script_templates/README
>  create mode 100644 tools/perf/new_script_templates/lib.rs
>  create mode 100644 tools/perf/new_script_templates/script.c
>  create mode 100644 tools/perf/util/new_script.c
>  create mode 100644 tools/perf/util/new_script.h
>  create mode 100644 tools/perf/util/new_script_rs_lib.h
> 
> -- 
> 2.46.0
> 
