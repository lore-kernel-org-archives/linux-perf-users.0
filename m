From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 25 Feb 2019 13:56:28 +0100
Message-ID: <20190225125628.GK19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-12-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:

SNIP

>  static int
>  do_switch_data(struct hist_browser *browser __maybe_unused,
>  	       struct popup_action *act __maybe_unused)
> @@ -3115,6 +3150,18 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
>  		}
>  		nr_options += add_script_opt(browser, &actions[nr_options],
>  					     &options[nr_options], NULL, NULL, evsel);
> +		nr_options += add_res_sample_opt(browser, &actions[nr_options],
> +						 &options[nr_options],
> +				 hist_browser__selected_entry(browser)->res_samples,
> +				 evsel, A_NORMAL);
> +		nr_options += add_res_sample_opt(browser, &actions[nr_options],
> +						 &options[nr_options],
> +				 hist_browser__selected_entry(browser)->res_samples,
> +				 evsel, A_ASM);
> +		nr_options += add_res_sample_opt(browser, &actions[nr_options],
> +						 &options[nr_options],
> +				 hist_browser__selected_entry(browser)->res_samples,
> +				 evsel, A_SOURCE);
>  		nr_options += add_switch_opt(browser, &actions[nr_options],
>  					     &options[nr_options]);

for some reason can't see those items in menu

jirka
