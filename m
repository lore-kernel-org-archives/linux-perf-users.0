Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF01422A2;
	Tue,  3 Sep 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384026; cv=none; b=SxvPiXtz17bmvxxVNcObPQ4XjDmJ41WsfFmHkQpICY515PSNQeeH2VfW0eCntnmBkOaCZMB8zHmGvvwAJWw1jylyGyT/0eRUsCEWDPdpjuGqRxeg0Pk0btp3naKuK/+N/MHAIt50ZsWBM64c/ydguhoKuYmeXGziGRpJ7iQtdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384026; c=relaxed/simple;
	bh=WbRROM7UwGBfTKCQYfar9UwHMh72zbO5Xvhf5N3xTzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs7Cdri2c9E2BdnpRZtXz4+wQ/Ah7d2wvSaHCl77QOTjv7XHSsvcWmhd5tv4nI5ah1CweX4hGqHpCjnBSy/43zeJUB1Tg/mZW49/cyjPP+dPg2V3j8oiTlE4v/pYTnpQe9zU7xs6vE2zp/tgaXZ2roFhD9ljIFKHzPgUZKJ+cMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apQxwB9I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apQxwB9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725384025; x=1756920025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WbRROM7UwGBfTKCQYfar9UwHMh72zbO5Xvhf5N3xTzw=;
  b=apQxwB9I51HvK3EYHi8nQQEFHbO4ZeUW54Vo4Yp1kEqEvKpitIC6ue2W
   9vKavw6HbWH1NiCNuB8WdPQONGktoQ+QDgANfHDeC6nTiG1QHRPQhkRwO
   qeKK+YTTO41HaWStF41Tgr6wRTxneAOTTzsY9iqptNPoJ8RKE2eXctTtp
   Au2sUzOGiy0sztLcL5Glo2LtWc2bcGEq6na8ixoywvoKjUvWMa2fhNFXN
   g3NJGVo7yh3ZV6n2foslHrYqUA9RYEtkD39mM/ctZMiuvtwFm54hE3aF+
   FC0+0E5i6dia8SC84BdDMZpQxpMYlV3stMxru7GkAQIlLl6KKM61Nx9Ru
   g==;
X-CSE-ConnectionGUID: 3MBwXEWMTECoyCwxVw7/3w==
X-CSE-MsgGUID: nwWSJ3ylSTimIizLK1yDzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34664150"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="34664150"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:20:24 -0700
X-CSE-ConnectionGUID: fOehwVKsRD2vXyhgnamsWg==
X-CSE-MsgGUID: w8ygrZ56THOVa7gBzoek1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69840874"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Sep 2024 10:20:22 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slXCV-0006xI-1M;
	Tue, 03 Sep 2024 17:20:19 +0000
Date: Wed, 4 Sep 2024 01:19:47 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Jihong <yangjihong@bytedance.com>, irogers@google.com,
	acme@redhat.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, yangjihong@bytedance.com
Subject: Re: [PATCH] tools lib subcmd: Use array data to save built usage
 string
Message-ID: <202409040112.BKj8VlQT-lkp@intel.com>
References: <20240903084048.766892-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903084048.766892-1-yangjihong@bytedance.com>

Hi Yang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc6 next-20240903]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Jihong/tools-lib-subcmd-Use-array-data-to-save-built-usage-string/20240903-164426
base:   linus/master
patch link:    https://lore.kernel.org/r/20240903084048.766892-1-yangjihong%40bytedance.com
patch subject: [PATCH] tools lib subcmd: Use array data to save built usage string
config: x86_64-randconfig-101-20240903 (https://download.01.org/0day-ci/archive/20240904/202409040112.BKj8VlQT-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409040112.BKj8VlQT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040112.BKj8VlQT-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   /usr/bin/ld: tools/objtool/libsubcmd/libsubcmd.a(libsubcmd-in.o): in function `parse_options_subcommand':
>> tools/lib/subcmd/parse-options.c:643: undefined reference to `scnprintf'
>> /usr/bin/ld: tools/lib/subcmd/parse-options.c:647: undefined reference to `scnprintf'
>> /usr/bin/ld: tools/lib/subcmd/parse-options.c:647: undefined reference to `scnprintf'
   /usr/bin/ld: tools/lib/subcmd/parse-options.c:651: undefined reference to `scnprintf'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)
   make[4]: *** [Makefile:75: tools/objtool/objtool] Error 1
   make[3]: *** [Makefile:72: objtool] Error 2
   make[2]: *** [Makefile:1360: tools/objtool] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +643 tools/lib/subcmd/parse-options.c

   631	
   632	int parse_options_subcommand(int argc, const char **argv, const struct option *options,
   633				const char *const subcommands[], const char *usagestr[], int flags)
   634	{
   635		struct parse_opt_ctx_t ctx;
   636	
   637		/* build usage string if it's not provided */
   638		if (subcommands && !usagestr[0]) {
   639			int n;
   640			static char buf[USAGESTR_BUF_SIZE];
   641			int buf_size = sizeof(buf);
   642	
 > 643			n = scnprintf(buf, buf_size, "%s %s [<options>] {",
   644				      subcmd_config.exec_name, argv[0]);
   645	
   646			for (int i = 0; subcommands[i] && n < buf_size - 1; i++) {
 > 647				n += scnprintf(buf + n, buf_size - n, "%s%s",
   648					       i ? "|" : "", subcommands[i]);
   649			}
   650			if (n < buf_size - 1)
   651				n += scnprintf(buf + n, buf_size - n, "}");
   652	
   653			/* only provided if a complete string is built */
   654			if (n < buf_size - 1)
   655				usagestr[0] = buf;
   656		}
   657	
   658		parse_options_start(&ctx, argc, argv, flags);
   659		switch (parse_options_step(&ctx, options, usagestr)) {
   660		case PARSE_OPT_HELP:
   661			exit(129);
   662		case PARSE_OPT_DONE:
   663			break;
   664		case PARSE_OPT_LIST_OPTS:
   665			while (options->type != OPTION_END) {
   666				if (options->long_name)
   667					printf("--%s ", options->long_name);
   668				options++;
   669			}
   670			putchar('\n');
   671			exit(130);
   672		case PARSE_OPT_LIST_SUBCMDS:
   673			if (subcommands) {
   674				for (int i = 0; subcommands[i]; i++)
   675					printf("%s ", subcommands[i]);
   676			}
   677			putchar('\n');
   678			exit(130);
   679		default: /* PARSE_OPT_UNKNOWN */
   680			if (ctx.argv[0][1] == '-')
   681				astrcatf(&error_buf, "unknown option `%s'",
   682					 ctx.argv[0] + 2);
   683			else
   684				astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
   685			usage_with_options(usagestr, options);
   686		}
   687	
   688		return parse_options_end(&ctx);
   689	}
   690	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
