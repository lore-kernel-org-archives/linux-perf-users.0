From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf inject: correct event attribute sizes
Date: Wed, 26 Aug 2020 12:27:45 +0100
Message-ID: <20200826112745.GB43491@C02TD0UTHF1T.local>
References: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Grant <al.grant@foss.arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, Denis Nikitin <denik@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Aug 26, 2020 at 10:42:04AM +0100, Al Grant wrote:
> When perf inject reads a perf.data file from an older version of perf,
> it writes event attributes into the output with the original size field,
> but lays them out as if they had the size currently used. Readers see
> a corrupt file. Update the size field to match the layout.
> 
> From: Denis Nikitin <denik@google.com>
> Signed-off-by: Al Grant <al.grant@foss.arm.com>

Did Denis write this patch?

If so, we need an S-o-B line from them.

Mark.

>  tools/perf/util/header.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9cf4efdcbbbd..762eb94bd532 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3326,6 +3326,14 @@ int perf_session__write_header(struct
> perf_session *session,
>         attr_offset = lseek(ff.fd, 0, SEEK_CUR);
> 
>         evlist__for_each_entry(evlist, evsel) {
> +               if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
> +                       /*
> +                        * We are likely in "perf inject" and have read +
> * from an older file. Update attr size so that
> +                        * reader gets the right offset to the ids.
> +                        */
> +                       evsel->core.attr.size = sizeof(evsel->core.attr);
> +               }
>                 f_attr = (struct perf_file_attr){
>                         .attr = evsel->core.attr,
>                         .ids  = {
