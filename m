From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf: fix documentation of the Flags section in perf.data
Date: Tue, 19 Feb 2019 15:04:59 +0100
Message-ID: <20190219140459.GE6435@krava>
References: <20190217232246.GB26460@krava>
 <20190218141846.2995-1-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218141846.2995-1-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 18, 2019 at 03:18:46PM +0100, Jonas Rabenstein wrote:
> According to the current documentation the flags section is placed after
> the file header itself but the code assumes to find the flags section
> after the data section. This change updates the documentation to that
> assumption.

missing your Signed-off-by

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/Documentation/perf.data-file-format.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 5f9a3924830b..593ef49b273c 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -43,11 +43,10 @@ struct perf_file_section {
>  
>  Flags section:
>  
> -The header is followed by different optional headers, described by the bits set
> -in flags. Only headers for which the bit is set are included. Each header
> -consists of a perf_file_section located after the initial header.
> -The respective perf_file_section points to the data of the additional
> -header and defines its size.
> +For each of the optional features a perf_file_section it placed after the data
> +section if the feature bit is set in the perf_header flags bitset. The
> +respective perf_file_section points to the data of the additional header and
> +defines its size.
>  
>  Some headers consist of strings, which are defined like this:
>  
> -- 
> 2.19.2
> 
