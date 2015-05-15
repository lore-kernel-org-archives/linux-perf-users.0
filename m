From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: How do you think about a time when selecting perf config file
 path ?
Date: Fri, 15 May 2015 21:40:53 +0900
Message-ID: <20150515124053.GB755@danjae.kornet>
References: <555440D8.6040201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33204 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422818AbbEOMmN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 15 May 2015 08:42:13 -0400
Received: by igbpi8 with SMTP id pi8so37775470igb.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2015 05:42:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555440D8.6040201@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: taeung <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi Taeung,

Please Cc Arnaldo and Jiri at least you want to talk about the perf
tools develeopment.  But I guess they already subscribed to this list
though. :)

On Thu, May 14, 2015 at 03:29:44PM +0900, taeung wrote:
> Hi, Namhyung
> 
> How do you think about a time when selecting perf config file path ?
> 
> At this present, perfconfig file path can be selected as '/etc/perfconfig'
> or '$(HOME)/.perfconfig'.
> And the config file path is selected when calling a function
> 'perf_config()'.

Yes, as far as I can see that it reads from both of global and local
config file and local setting overwrites the global one.

> 
> If you see functions 1,2,3,4 as below, you can understand what I agonize. I
> think that the part which perf config path is selected must be separated as
> other function to also use the function in 'cmd_config()' in new
> builtin-config.c.

Please don't agonize. :)

I think you can extend perf_config_system() and perf_config_global() -
they need to be renamed IMHO - to select which config to be used.


> 
> For example,
> If adding a option '--global' or '--local' for config file path,
> the perf config file name have to selected in 'cmd_config()' before
> 'perf_config()' is called.
> 
> How do you think about this ?

Yes, you can add a variable like config_src to select it..

enum {
  BOTH,
  GLOBAL_ONLY,
  LOCAL_ONLY,
} config_src = BOTH;

cmd_config() {
  ...

  if (global)
    config_src = GLOBAL_ONLY;
  else if (local)
    config_src = LOCAL_ONLY;

  ...

  perf_config()
}

perf_config_system()
{
  return config_src != LOCAL_ONLY && ...;
}

perf_config_global()
{
  return config_src != GLOBAL_ONLY && ...;
}

Thanks,
Namhyung


> 
> Thanks,
> Taeung
> 
> 1. a function 'perf_config()' in util/config.c
> 
> ========
> int perf_config(config_fn_t fn, void *data)
> {
> 	int ret = 0, found = 0;
> 	const char *home = NULL;
> 
> 	/* Setting $PERF_CONFIG makes perf read _only_ the given config file. */
> 	if (config_exclusive_filename)
> 		return perf_config_from_file(fn, config_exclusive_filename, data);
> 	if (perf_config_system() && !access(perf_etc_perfconfig(), R_OK)) {
> 		ret += perf_config_from_file(fn, perf_etc_perfconfig(),
> 					    data);
> 		found += 1;
> 	}
> 
> 	home = getenv("HOME");
> 	if (perf_config_global() && home) {
> 		char *user_config = strdup(mkpath("%s/.perfconfig", home));
> 		struct stat st;
> 
> 		if (user_config == NULL) {
> 			warning("Not enough memory to process %s/.perfconfig, "
> 				"ignoring it.", home);
> 			goto out;
> 		}
> 
> 		if (stat(user_config, &st) < 0)
> 			goto out_free;
> 
> 		if (st.st_uid && (st.st_uid != geteuid())) {
> 			warning("File %s not owned by current user or root, "
> 				"ignoring it.", user_config);
> 			goto out_free;
> 		}
> 
> 		if (!st.st_size)
> 			goto out_free;
> 
> 		ret += perf_config_from_file(fn, user_config, data);
> 		found += 1;
> out_free:
> 		free(user_config);
> 	}
> out:
> 	if (found == 0)
> 		return -1;
> 	return ret;
> }
> ========
> 
> 2. 'perf_config_from_file()' in util/config.c I modified
> 
> ========
> int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
> {
> 	int ret;
> 	FILE *f = fopen(filename, "r");
> 
> 	ret = -1;
>  	if (f) {
>  		config_file = f;
> -		config_file_name = filename;
> +		config_file_name = strdup(filename);
>  		config_linenr = 1;
>  		config_file_eof = 0;
>  		ret = perf_parse_file(fn, data);
>  		fclose(f);
> -		config_file_name = NULL;
>  	}
> 	return ret;
> }
> ========
> 
> 3. 'perf_configset_write_in_full()' in util/config.c that I added as new a
> function because of new 'perf config' command. And this function use a
> global variable 'config_file_name' to rewrite config file with new config
> contents.
> (To add new command 'perf-config', I try to modify this file
> 'util/config.c')
> 
> ========
> +int perf_configset_write_in_full(void)
> +{
> +	struct config_section *section_node;
> +	struct config_element *element_node;
> +	const char *first_line = "# this file is auto-generated.";
> +	FILE *fp = fopen(config_file_name, "w");
> +
> +	if (!fp)
> +		return -1;
> +
> +	fprintf(fp, "%s\n", first_line);
> +	/* overwrite configvariables */
> +	list_for_each_entry(section_node, sections, list) {
> +		fprintf(fp, "[%s]\n", section_node->name);
> +		list_for_each_entry(element_node, &section_node->element_head, list) {
> +			if (element_node->value)
> +				fprintf(fp, "\t%s = %s\n",
> +					element_node->subkey, element_node->value);
> +		}
> +	}
> +	fclose(fp);
> +
> +	return 0;
> +}
> ========
> 
> 4. a new function 'cmd_config()' in new file builtin-config.c.
> (If working a command as '$ perf config', cmd_config() is firstly called.
> This function is also added by me.)
> 
> ========
> +int cmd_config(int argc, const char **argv, const char *prefix
> __maybe_unused)
> +{
> +	int i, ret = 0;
> +	int origin_argc = argc - 1;
> +	char *value;
> +	bool is_option;
> +
> +	argc = parse_options(argc, argv, config_options, config_usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (origin_argc > argc)
> +		is_option = true;
> +	else
> +		is_option = false;
> +
> +	if (!is_option && argc >= 0) {
> +		switch (argc) {
> +		case 0:
> +			break;
> +		default:
> +			for (i = 0; argv[i]; i++) {
> +				value = strrchr(argv[i], '=');
> +				if (value == NULL || value == argv[i])
> +					ret = perf_configset_with_option(show_spec_config, argv[i]);
> +				else
> +					ret = perf_configset_with_option(set_spec_config, argv[i]);
> +				if (ret < 0)
> +					break;
> +			}
> +			goto out;
> +		}
> +	}
> +	if (params.list_action && argc == 0)
> +		ret = perf_config(show_config, NULL);
> +	else {
> +		pr_warning("Error: Unknown argument.\n");
> +		usage_with_options(config_usage, config_options);
> +	}
> +
> +	return ret;
> +}
> ========
