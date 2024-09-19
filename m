Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAD1CD02;
	Thu, 19 Sep 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782676; cv=none; b=ixFErG9gVmpO5zsV1OkijTfdo3cDEwaGe7mzPuqFKDG418qsDYkgZR3TC+nYgqZGd57JlpkG1YWzaJl44JAh2ka958P8X4gTnXrXfBO4hMKiIVLrTa9SC6aUQ/1hfMj2wK7znIZ0LQbqOEUVpPAxIJRsFHBwj3DDejSJVJUwehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782676; c=relaxed/simple;
	bh=BQdMbmq+fCbtDSNllFP6RG2/YbKG4/P8pBogWVuSLpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rc61zCjeAow+ZulPF/NO5ETjEAv9j9sArEdw6aXMxDR7f9zQ3PUrFY+0Nkzsjk17pnxzUq6V+Rbu3K6FWijNfDdOiPJV7qsqKbntnTQFl8+DND3ZZUbIplSLJ+jc9l2IvkedtWpJxCtBvqQGTbjqxhtffDB7FrBSpRq1BnWSEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=permerror (bad message/signature format); arc=none smtp.client-ip=198.175.65.9
Authentication-Results:smtp.subspace.kernel.org; dkim=permerror (bad message/signature format)
X-CSE-ConnectionGUID: TTkeb9n5Q0uurwAdxw1Iow==
X-CSE-MsgGUID: GZGmEU06SyCALPgjMADcYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48305685"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48305685"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:51:14 -0700
X-CSE-ConnectionGUID: EZ0raVcoRiuNBS93fCVzcQ==
X-CSE-MsgGUID: WwWBsvhVQOKeDONNlXCW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74866704"
Received: from b04f130c8410.jf.intel.com ([10.165.154.100])
  by orviesa003.jf.intel.com with ESMTP; 19 Sep 2024 14:51:14 -0700
From: Stefan Ene
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vinicius.gomes@intel.com,
	stefan.ene@intel.com,
	stef_an_ene@outlook.com
Subject: [RFC v1 0/3] C and Rust support for perf script
Date: Thu, 19 Sep 2024 14:51:01 -0700
Message-ID: <20240919215107.2263552-2-stefan.ene@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Ene <stefan.ene@intel.com>

============================COVER=LETTER============================

This proposal is addressing the usability and performance of the available scripting languages for custom perf event data processing inside of the perf toolset, specifically with the perf script command.

With the perf-script custom event processing functionality for C and Rust, we noticed between 2x to 5x speed improvement with our new methods compared to the existent Python and Perl scripting methods.

To explain the proposed method, you begin with the C or Rust script we’ve templatized, then just add changes for custom event processing in the preferred language using this provided template, compile the respective script into a dynamic library, then give the resulting .so file as a parameter to the newly implemented perf script option.

List of functionality additions:

1/ Added new "--new_script" option inside the perf script command that takes in as parameter .so files. Code addition in tools/perf/builtin-script.c

2/ The functional code for the newly implemented option was added to the tools/perf/util/new_script.c and tools/perf/util/new_script.h files.

3/ Folder added at tools/perf/new_script_templates, containing C and Rust script templates for the new option, along with compilation instructions.

4/ Finally, a short bash script for updating the perf tool set within the kernel code was provided in the base-level file update_perf_tools.sh.


Common Questions

* How can I use the new toolset?

   The new implementations for the perf script have a detailed usage guide inside of the tools/perf/new_script_templates/README file, along with some script templates for C and Rust!

* Why a new option instead of expanding dlfilter?

   The new option gave us the flexibility to make use of the fast dlfilter dynamic library approach, as opposed to implementing another interpreting methodology. This allows for scalability, with great potential to other languages supporting dynamic library calls from the base C code.

* Why use C and Rust instead?

   As of kernel version 6.11, the perf tool has a large overhead for data processing using Python and Perl, given the languages having to use their respective perf built-in interpreters. Furthermore, while Python is widley used in the development comunity, as of 20204, Perl is only used by 2.5 of developers worldwide, while C and Rust are more common, with 20.3% and 12.6% usage, respectively (Source: statista.com).

* What are the actual performance improvements?

   As last tested, the C and Rust approach are anywhere between 2 to 5 times faster than the existent Python and Perl scripting methods, with Rust being the fastest all across!


Acknowledgements:

This code was completed as part of an Intel summer internship project, under the mentoring of Vinicius Gomes, Intel Linux Kernel Team.

=========================END=COVER=LETTER===========================


Stefan Ene (3):
  add the new perf script option (--new_script) and related changes
  added the C sample script
  added the Rust sample script

 tools/perf/builtin-script.c              |  22 +-
 tools/perf/new_script_templates/README   |  65 ++++
 tools/perf/new_script_templates/lib.rs   | 108 +++++++
 tools/perf/new_script_templates/script.c | 113 +++++++
 tools/perf/util/Build                    |   1 +
 tools/perf/util/new_script.c             | 376 +++++++++++++++++++++++
 tools/perf/util/new_script.h             |  54 ++++
 tools/perf/util/new_script_rs_lib.h      |  35 +++
 8 files changed, 773 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/new_script_templates/README
 create mode 100644 tools/perf/new_script_templates/lib.rs
 create mode 100644 tools/perf/new_script_templates/script.c
 create mode 100644 tools/perf/util/new_script.c
 create mode 100644 tools/perf/util/new_script.h
 create mode 100644 tools/perf/util/new_script_rs_lib.h

-- 
2.46.0

