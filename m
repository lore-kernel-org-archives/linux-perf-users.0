From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH 1/3] perf alias: Remove trailing newline when reading
 sysfs files
Date: Thu, 14 Jun 2018 08:17:47 -0500
Message-ID: <c29a4b36-a2db-b1d9-a5c7-a0c0806970ab@us.ibm.com>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614114845.41221-1-tmricht@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 06/14/2018 06:48 AM, Thomas Richter wrote:
> Remove a trailing newline when reading sysfs file contents
> such as /sys/devices/cpum_cf/events/TX_NC_TEND.
> This show when verbose option -v is used.
> 
> Output before:
> tx_nc_tend -> 'cpum_cf'/'event=0x008d
> '/
> 
> Output after:
> tx_nc_tend -> 'cpum_cf'/'event=0x8d'/
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/pmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 7878934ebb23..26c79a9c4142 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -294,7 +294,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> 
>  static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FILE *file)
>  {
> -	char buf[256];
> +	char *cp, buf[256];
>  	int ret;
> 
>  	ret = fread(buf, 1, sizeof(buf), file);
> @@ -303,6 +303,11 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
> 
>  	buf[ret] = 0;
> 
> +	/* Remove trailing newline from sysfs file */
> +	cp = strrchr(buf, '\n');
> +	if (cp)
> +		*cp = '\0';

A nit, perhaps, but this will search backwards through the entire string if a newline is not found, which is the most common case, I presume.  Would it be more efficient to just look at the last character?  Something like:
i = strlen(buf);
if (i > 0 && buf[i-1] == '\n')
  buf[i-1] = '\0';

> +
>  	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
>  				     NULL, NULL, NULL);
>  }
> 

PC
